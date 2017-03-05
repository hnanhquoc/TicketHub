class EventsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index, :show]
  def index
  	if params[:search]
  		@events = Event.search(params[:search]).order("starts_at DESC")
  	else
    	@events = Event.current.order("starts_at DESC") + Event.upcoming.order("starts_at DESC")
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params 
    @event.created_by = current_user.email
    if @event.save
      flash[:success] = "Event created successful!"
      redirect_to events_path
      else
      flash[:error] = "Error: #{@event.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  def mine
    @events = Event.where("created_by = ?", current_user.email)
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
  	params.require(:event).permit(:id, :search, :name, :extended_html_description, :hero_image_url, :venue_id, :category_id, :starts_at, :ends_at)
  end
end