class EventsController < ApplicationController
  def index
    @events = Event.paginate(page: params[:page])
    Rails.cache.fetch(User.cache_key_for_user(@user), expires_in: 2.minutes) do
        if stale?([@user, @user.updated_at, @user.events])
          @user = User.find(current_user.id)
          #fresh_when(last_modified: @user.updated_at.utc, etag: @user)
        end
    end
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
    Rails.cache.fetch(Event.cache_key_for_event(@event), expires_in: 2.minutes) do
        if stale?([@event, @event.updated_at, @event.host])
          @event = Event.find(params[:id])
        #fresh_when(last_modified: @event.updated_at.utc, etag: @event)
        end
    end
  end

  def update
    Rails.cache.fetch(Event.cache_key_for_event(@event), expires_in: 2.minutes) do
        if stale?([@event, @event.updated_at, @event.host])
          @event = Event.find(params[:id])
          #fresh_when(last_modified: @event.updated_at.utc, etag: @event)
        end
    end
    if @event.update_attributes(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end

  def show
    Rails.cache.fetch(Event.cache_key_for_event(@event), expires_in: 2.minutes) do
        if stale?([@event, @event.update_at, @event.host])
          @event = Event.find(params[:id])
          #fresh_when last_modified: @event.updated_at.utc, etag: @event
        end
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
