class Event < ApplicationRecord
    attribute :name, :string
    attribute :date, :string
    attribute :time, :string
    attribute :description, :string
    attribute :host, :integer

    belongs_to :user, :foreign_key => :user_id, optional: true
	has_many :members, dependent: :destroy
    has_many :users, :through => :members
    has_many :guests
    has_many :invitees, source: :user, :through => :guests
    validates_presence_of :description, :date, :time

end
