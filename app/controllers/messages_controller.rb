class MessagesController < ApplicationController
  before_action :correct_user

  def index
    @conversations = Conversation.user(current_user).includes([:sender, :recipient, :messages])
    @conversation = Conversation.find(params[:conversation_id])
    @messages = @conversation.messages.includes(:user).paginate(page: params[:page], per_page: 20).order('created_at DESC')
    @message = @conversation.messages.new
  end

  def new
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.new
  end

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

private
  def message_params
    params.require(:message).permit(:body, :user_id)
  end
  
  def correct_user
     @conversation = Conversation.find(params[:conversation_id])
     redirect_to(root_url) unless (@conversation.send_id == current_user.id || @conversation.recv_id == current_user.id)
  end
  
  def is_mutual
    @conversation = Conversation.find(params[:conversation_id])
    redirect_to(root_url) unless (@conversation.mutual)
  end
end
