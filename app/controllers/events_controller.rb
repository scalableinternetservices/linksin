class EventsController < ApplicationController
  def index
  	@events = Event.paginate(page: params[:page])
    @user = User.find(current_user.id)
  end
  def new
  	@event = Event.new
  end

  def create
    @event = Event.new(event_params)
    addEventHost()
    unless @event.guests.blank?
      @event.guests.each do |guest|
        guest.events << @event
      end
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def addEventHost
    id = @event.host.to_i
    User.find(current_user.id).events << @event
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :time, :description, :host, :guests)
  end

end
