require "rails_helper"

RSpec.describe "routes for Event", :type => :routing do
	it "routes get event_tickets_path" do
		expect(get("/events/1/tickets")).to route_to(:controller => "tickets", :action => "index", :event_id => "1")
	end

	it "routes post event_tickets_path" do
		expect(post("/events/1/tickets")).to route_to(:controller => "tickets", :action => "create", :event_id => "1")
	end

	it "routes get new_event_ticket_path" do
		expect(get("/events/1/tickets/new")).to route_to(:controller => "tickets", :action => "new", :event_id => "1")
	end

	it "routes get edit_event_ticket_path" do
		expect(get("/events/1/tickets/100/edit")).to route_to(:controller => "tickets", :action => "edit", :event_id => "1", :id => "100")
	end

	it "routes get event_ticket_path" do
		expect(get("/events/1/tickets/100")).to route_to(:controller => "tickets", :action => "show", :event_id => "1", :id => "100")
	end

	it "routes patch event_ticket_path" do
		expect(patch("/events/1/tickets/100")).to route_to(:controller => "tickets", :action => "update", :event_id => "1", :id => "100")
	end

	it "routes put event_ticket_path" do
		expect(put("/events/1/tickets/100")).to route_to(:controller => "tickets", :action => "update", :event_id => "1", :id => "100")
	end

	it "routes delete event_ticket_path" do
		expect(delete("/events/1/tickets/100")).to route_to(:controller => "tickets", :action => "destroy", :event_id => "1", :id => "100")
	end

end