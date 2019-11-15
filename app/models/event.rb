class Event < ApplicationRecord
    attribute :name, :string
    attribute :date, :string
    attribute :time, :string
    attribute :description, :string
    attribute :host, :integer
    attribute :guests

    belongs_to :user, :foreign_key => :user_id, optional: true
	has_many :members
    has_many :users, :through => :members
    validates_presence_of :description, :date, :time
end
