require "rails_helper"

RSpec.describe Region, :type => :model do
  it "has none to begin with" do
    expect(Region.count).to eq 0
  end

  it "has to match validations" do
    r = Region.create(name: 'HCM')
    expect(r.id).to eq nil
  end

  it "has one after adding one" do
    Region.create(name: 'Ho Chi Minh')
    expect(Region.count).to eq 1
  end

  it "has none after one was created in a previous example" do
    expect(Region.count).to eq 0
  end
end