class EventsController < ApplicationController
  def index
  	@events = Event.paginate(page: params[:page])
    @user = User.find(current_user.id)
    fresh_when([@user, @user.updated_at.utc, @user.events])
  end
  def new
  	@event = Event.new if stale?(Event.all)
  end

  def create
    @event = Event.new(event_params) if stale?(Event.all)
    addEventHost()
    invite_ids = params[:user_ids]
    unless invite_ids.nil?
        invite_ids.each do |id|
        User.find(id).invites << @event
      end
    end
  end


  def edit
    @event = Event.find(params[:id])
    fresh_when last_modified: @event.updated_at.utc, etag: @event
  end

  def update
    @event = Event.find(params[:id])
    fresh_when last_modified: @event.updated_at.utc, etag: @event
    if @event.update_attributes(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end

  def show
    @event = Event.find(params[:id])
    fresh_when last_modified: @event.updated_at.utc, etag: @event
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
