class EventsController < ApplicationController
  def index
  	if params[:search]
  		@events = Event.search(params[:search]).order("starts_at DESC")
  	else
    	@events = Event.current.order("starts_at DESC") + Event.upcoming.order("starts_at DESC")
    end
  end

  def edit
  	if params[:id]
  		@event = Event.find(params[:id])
  	end
  end

  def show
    @event = Event.find(params[:id])
  end

  def event_params
  	params.require(:event).permit(:id, :search)
  end
end