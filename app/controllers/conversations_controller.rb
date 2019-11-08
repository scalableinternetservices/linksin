class ConversationsController < ApplicationController
  before_action :current_user
  def matches
    @users = User.all
    @conversations = Conversation.all
  end

  def index
    @conversations = Conversation.user(current_user)
    redirect_to conversation_messages_path(@conversations.first)
  end

  def create
    if Conversation.between(params[:send_id],params[:recv_id]).present? #already exists, so we set matched to true and allow conversation
      @conversation = Conversation.between(params[:send_id], params[:recv_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

private

  def conversation_params
    params.permit(:send_id, :recv_id)
  end
end