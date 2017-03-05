require 'rails_helper'

RSpec.describe EventsController, type: :controller do
	describe "load /index" do
		it "response 200 when visiting" do
			get :index
			expect(response).to have_http_status(200)
		end

	end
end
