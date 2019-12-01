class MessagesController < ApplicationController
  before_action do
    @conversations = Conversation.user(current_user)
    @conversation = Conversation.find(params[:conversation_id])
  end
  before_action :correct_user

  def index
    @messages = @conversation.messages.paginate(page: params[:page], per_page: 20).order('created_at DESC')
    @message = @conversation.messages.new if stale? (Message.all)
  end

  def new
    @message = @conversation.messages.new if stale? (Message.all)
  end

  def create
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
     redirect_to(root_url) unless (@conversation.send_id == current_user.id || @conversation.recv_id == current_user.id)
  end
  
  def is_mutual
    redirect_to(root_url) unless (@conversation.mutual)
  end
end
