class ConversationsController < ApplicationController
  before_action :current_user
  
  def matches
    @users = User.all
    @conversations = Conversation.all
  end

  def index
    @conversations = Conversation.user(current_user)
    unless @conversations.empty?
      redirect_to conversation_messages_path(@conversations.first)
    end
  end

  def create
    if Conversation.between(params[:send_id],params[:recv_id]).present? #already exists
      @conversation = Conversation.between(params[:send_id], params[:recv_id]).first
      unless @conversation.send_id == current_user.id #match if we weren't the initiator
        @conversation.update_attributes(mutual: true)
        flash[:success] = "It's mutual!"
        redirect_to conversation_messages_path(@conversation)
      else 
        flash[:danger] = "Patience, mate; you've got to give them some time to respond!"
        redirect_to current_user
      end
    else
      @conversation = Conversation.create!(conversation_params)
      redirect_to current_user
    end
  end

private

  def conversation_params
    params.permit(:send_id, :recv_id)
  end
end