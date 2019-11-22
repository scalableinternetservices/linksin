# frozen_string_literal: true

# User Model
#
# User.new to create a new user
# User.save to save an user to database
# User.create to create a new user and save it to database
# User.destroy to destroy an user from database
# User.find(id: number) to find an user with specific id
# User.find_by(key: value) to find an user with specific key value pair
# User.first returns the first user in the database
# User.all to get all the users
#
# User.update_attributes(key: value)
# to update the user to have specific key value pairs
#
# User.update_attribute(key, value)
# to update the user to have specific key value pair
#
class User < ApplicationRecord
  # name
  validates :name,
            presence: true,
            length: { maximum: 50 }

  # email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  before_save { self.email = email.downcase }

  # password
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_one :profile, dependent: :destroy
  has_many :conversations, :foreign_key => :send_id
  
  after_create :build_profile

  has_many :microposts
  has_many :members
  has_many :events, :through => :members
  attr_accessor :remember_token
    
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def build_profile
    Profile.create(user: self) # Associations must be defined correctly for this syntax, avoids using ID's directly.
  end

  # User Caching
  def User.cache_key_for_user(x)
    "user-#{x.id}-#{x.updated_at}-#{x.events.count}"
  end

  def User.cache_key_for_userCards
    "userCards-#{User.maximum(:updated_at)}"
  end
end