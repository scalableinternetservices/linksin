class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User', :foreign_key => :send_id
  belongs_to :recipient, class_name: 'User', :foreign_key => :recv_id
   
  has_many :messages, dependent: :destroy
  
  belongs_to :sender_name_email_only, -> {select('users.id, users.name, users.email')}, class_name: 'User', foreign_key: 'send_id'
  belongs_to :recipient_name_email_only, -> {select('users.id, users.name, users.email')}, class_name: 'User', foreign_key: 'recv_id'
  has_one :last_message, -> { order(created_at: :desc) }, class_name: 'Message'
  
  validates_uniqueness_of :send_id, :scope => :recv_id
  
  scope :between, -> (send_id,recv_id) do
    where("(conversations.send_id = ? AND conversations.recv_id =?) OR (conversations.send_id = ? AND conversations.recv_id =?)", send_id,recv_id, recv_id, send_id)
  end
  
  scope :user, -> (user_id) do
    where("(conversations.send_id = ? OR conversations.recv_id = ?)", user_id, user_id)
  end

end
