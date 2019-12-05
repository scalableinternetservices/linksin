class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  belongs_to :user_name_only, -> {select('users.id, users.name')}, class_name: 'User', foreign_key: 'user_id'
  validates_presence_of :body, :conversation_id, :user_id

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end

end
