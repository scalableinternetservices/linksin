class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User', :foreign_key => :send_id
  belongs_to :recipient, class_name: 'User', :foreign_key => :recv_id
   
  has_many :messages, dependent: :destroy
  
  validates_uniqueness_of :send_id, :scope => :recv_id
  
  scope :between, -> (send_id,recv_id) do
    where("(conversations.send_id = ? AND conversations.recv_id =?) OR (conversations.send_id = ? AND conversations.recv_id =?)", send_id,recv_id, recv_id, send_id)
  end
  
  scope :user, -> (user_id) do
    where("(conversations.send_id = ? OR conversations.recv_id = ?)", user_id, user_id)
  end

  def Conversation.cache_key_for_conversation(x)
    "conversation-#{x.send_id}-#{x.recv_id}-#{x.updated_at}"
  end

  def Conversation.cache_key_for_conversations
    "conversation-#{Conversation.maximum(:updated_at)}"
  end

end
