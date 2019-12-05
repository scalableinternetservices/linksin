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
    invite_ids = params[:user_ids]
    unless invite_ids.nil?
        invite_ids.each do |id|
        User.find(id).invites << @event
      end
    end
  end

  def edit
    if stale?([@event, @event.updated_at])
      @event = Event.find(params[:id])
    end
  end

  def update
    if stale?([@event, @event.updated_at])
      @event = Event.find(params[:id])
    end
    if @event.update_attributes(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end

  def show
    if stale?([@event, @event.updated_at])
      @event = Event.find(params[:id])
    end
  end

  def addEventHost
    @event.host = current_user.id
    User.find(current_user.id).events << @event
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :time, :description, :host, :guests)
  end

end
