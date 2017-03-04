require 'rails_helper'

RSpec.describe EventsController, type: :controller do
	describe "load /index" do
		it "response 200 when visiting" do
			get :index
			expect(response).to have_http_status(200)
		end

		it "load events" do
			event = Event.new
			event.save(validate: false)
			get :index
			expect(assigns(:events)).to eq [event]
		end
	end
end
