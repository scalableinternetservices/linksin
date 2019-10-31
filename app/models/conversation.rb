class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User', :foreign_key => :send_id
  belongs_to :recipient, class_name: 'User', :foreign_key => :recv_id
   
  has_many :messages, dependent: :destroy
  
  validates_uniqueness_of :send_id, :scope => :recv_id
  
  scope :between, -> (send_id,recv_id) do
    where("(conversations.send_id = ? AND conversations.recv_id =?) OR (conversations.send_id = ? AND conversations.recv_id =?)", send_id,recv_id, recv_id, send_id)
  end
end
