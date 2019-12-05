class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  validates_presence_of :body, :conversation_id, :user_id

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end

  def Message.cache_key_for_message(x)
    "message-#{x.user_id}-#{x.conversation_id}-#{x.created_at}-#{x.id}"
  end

  def Message.cache_key_for_messages
    "message-#{Message.maximum(:updated_at)}"
  end

end
