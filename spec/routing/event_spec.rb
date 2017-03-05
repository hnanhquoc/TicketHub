require "rails_helper"

RSpec.describe "routes for Event", :type => :routing do
	it "routes /upcoming to the event controller" do
		expect(get("/upcoming")).to route_to("events#index")
	end

	it "routes /root_path to the event controller" do
		expect(get("/")).to route_to("events#index")
	end

	it "routes get events_path to the event controller" do
		expect(get("/events")).to route_to("events#index")
	end

	it "routes post events_path to the event controller" do
		expect(post("/events")).to route_to("events#create")
	end

	it "routes /new_event_path to the event controller" do
		expect(get("/events/new")).to route_to("events#new")
	end

	it "routes /edit_event_path to the event controller" do
		expect(get("/events/1/edit")).to route_to( :controller => "events",
			:action => "edit",
			:id => "1")
	end

	it "routes get /event_path to the event controller" do
		expect(get("/events/1")).to route_to( :controller => "events",
			:action => "show",
			:id => "1")
	end

	it "routes put /event_path to the event controller" do
		expect(put("/events/1")).to route_to( :controller => "events",
			:action => "update",
			:id => "1")
	end

	it "routes patch /event_path to the event controller" do
		expect(patch("/events/1")).to route_to( :controller => "events",
			:action => "update",
			:id => "1")
	end

	it "routes delete /event_path to the event controller" do
		expect(delete("/events/1")).to route_to( :controller => "events",
			:action => "destroy",
			:id => "1")
	end


end