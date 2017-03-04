require "rails_helper"

RSpec.describe "routes for Event", :type => :routing do
  it "routes /upcoming to the widgets controller" do
    expect(get("/upcoming")).to route_to("events#index")
  end
end