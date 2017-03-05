require 'rails_helper'

RSpec.describe Event, type: :model do
  describe ".upcoming" do
  	it "should return [] when there no events" do
  		expect(Event.upcoming).to eq []
  	end

  	it "should return 0 when there is one event, not published" do
  		event = Event.new starts_at: Date.parse("2017/12/12")
  		event.save(validate: false)
  		expect(Event.upcoming).to eq []
  	end

    it "should return 1 when there is one event, published" do
      event = Event.new starts_at: Date.parse("2017/12/12"), published_at: Time.now
      event.save(validate: false)
      expect(Event.upcoming).to eq [event]
    end

  	it "return only upcoming published event" do
  		a = Event.new starts_at: 1.day.ago, published_at: Time.now
  		b = Event.new starts_at: 2.day.from_now, published_at: Time.now
  		c = Event.new starts_at: 1.day.from_now, published_at: Time.now

  		b.save(validate: false)
  		c.save(validate: false)
  		a.save(validate: false)

  		expect(Event.upcoming).to match_array [c, b]
  	end
  end

  describe ".current" do
    it "should return [] when there no events" do
      expect(Event.current).to eq []
    end

    it "should return 0 when there is one event, not published" do
      event = Event.new starts_at: Time.now
      event.save(validate: false)
      expect(Event.current).to eq []
    end

    it "should return 1 when there is one event, published" do
      event = Event.new starts_at: Time.now, ends_at: 1.day.from_now, published_at: Time.now
      event.save(validate: false)
      expect(Event.current).to eq [event]
    end

    it "return only current event" do
      a = Event.new starts_at: 1.day.ago, ends_at: 1.day.ago, published_at: Time.now
      b = Event.new starts_at: 1.day.ago, ends_at: 1.day.from_now, published_at: Time.now
      c = Event.new starts_at: 1.day.from_now, published_at: Time.now

      b.save(validate: false)
      c.save(validate: false)
      a.save(validate: false)

      expect(Event.current).to match_array [b]
    end
  end

end
