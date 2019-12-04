class ConversationsController < ApplicationController
  before_action :current_user
  
  def matches
    @conversations = Conversation.user(current_user).includes([:sender => :profile, :recipient => :profile])
  end

  def index
    @conversations = Conversation.user(current_user)
    unless @conversations.empty?
      redirect_to conversation_messages_path(@conversations.first)
    end
  end

  def create
    if Conversation.between(conversation_params[:send_id],conversation_params[:recv_id]).present? #already exists
      @conversation = Conversation.between(conversation_params[:send_id],conversation_params[:recv_id]).first
      redirect_to conversation_messages_path(@conversation)
    else
      @conversation = Conversation.create!(conversation_params)
      redirect_to conversation_messages_path(@conversation)
    end
  end

private

  def conversation_params
    params.require(:conversation).permit(:send_id, :recv_id)
  end
end