require 'rails_helper'

RSpec.describe Event, type: :model do
  describe ".upcoming" do
  	it "should return [] when there no events" do
  		expect(Event.upcoming).to eq []
  	end

  	it "should return 1 when there is one event" do
  		event = Event.new starts_at: Date.parse("2017/12/12")
  		event.save(validate: false)
  		expect(Event.upcoming).to eq [event]
  	end

  	it "return only upcoming event" do
  		a = Event.new starts_at: 1.day.ago
  		b = Event.new starts_at: 2.day.from_now
  		c = Event.new starts_at: 1.day.from_now

  		b.save(validate: false)
  		c.save(validate: false)
  		a.save(validate: false)

  		expect(Event.upcoming).to match_array [c, b]
  	end
  end
end
