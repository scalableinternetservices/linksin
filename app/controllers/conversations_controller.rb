class ConversationsController < ApplicationController
  before_action :current_user
  
  def matches
    @users = User.all
    @conversations = Conversation.user(current_user)
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
      redirect_to conversation_messages_path(@conversation)
    else
      @conversation = Conversation.create!(conversation_params)
    end
  end

private

  def conversation_params
    params.permit(:send_id, :recv_id)
  end
end