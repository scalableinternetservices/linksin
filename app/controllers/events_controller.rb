class EventsController < ApplicationController
  def index
    @user = current_user
    @events = @user.events.includes([:invitees_name_only, :users_name_only])
  end
  
  def new
  	@event = Event.new
    @conversations = Conversation.user(current_user.id).includes([:sender_name_email_only, :recipient_name_email_only])
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
    @event.host = current_user.id
    User.find(@event.host).events << @event
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :time, :description, :host, :guests)
  end

end
