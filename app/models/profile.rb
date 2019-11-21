class Profile < ApplicationRecord
  belongs_to :user, :foreign_key => :user_id
  validates_uniqueness_of :user_id
  validates :description, length: { maximum: 255 }
  
end
