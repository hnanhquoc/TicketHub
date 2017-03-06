class EventsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :check_event_changing_permission, only: [:publish, :edit]

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
  if params[:event][:venue_id] == 'New Value'
    @venue = Venue.new region_id: params[:event][:venue_region_id], name: params[:venue_name], full_address: params[:venue_full_address]
    if !@venue.save!
      flash[:error] = "Error: #{@venue.errors.full_messages.to_sentence}"
      render 'new'
    end
  else
    @venue = Venue.find_by_id(params[:event][:venue_id])
  end

  if params[:ticket_types].nil? || params[:ticket_types].empty?
    flash[:error] = "Please add at least one ticket type"
    render 'new'
  end

  @event = Event.new event_params 
  @event.venue = @venue
  @event.created_by = current_user.email
  if @event.save
    params[:ticket_types].each do |key, t|
      TicketType.create! event_id: @event.id, name: t[:name], price: t[:price], max_quantity: t[:max_quantity]
    end
    flash[:success] = "Event created successful!"
    redirect_to mine_events_path
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

def publish
  if params[:id]
    @event = Event.find(params[:id])
    if !@event.published?
    @event.publish!
    flash[:success] = "Event published successful!"
  else
    flash[:notice] = "Event published already!"
  end
    redirect_to mine_events_path
  else
    flash[:error] = "Select an event to publish"
    render 'mine'
  end
end

def show
  @event = Event.find(params[:id])
end

def check_event_changing_permission
  @event = Event.find(params[:id])
  unless @event.created_by == current_user.email
    flash[:error] = "You're not authorized to do this action"
    redirect_to events_path
  end
end

def event_params
 params.require(:event).permit(:id, :search, :name, :extended_html_description, :hero_image_url, :venue_id, :category_id, :starts_at, :ends_at, ticket_types: [])
end
end