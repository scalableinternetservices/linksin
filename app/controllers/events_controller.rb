class EventsController < ApplicationController
  def index
  	@events = Event.paginate(page: params[:page])
  end
  def new
  	@event = Event.new
  end
end
