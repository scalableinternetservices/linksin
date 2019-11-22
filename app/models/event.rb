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

      # Event Caching
    def Event.cache_key_for_event(e)
        "event-#{e.id}-#{e.updated_at}-#{e.members.count}"
    end

    def Event.cache_key_for_eventList
        "eventList-#{Event.maximum(:updated_at)}-#{Member.maximum(:updated_at)}"
    end
end
