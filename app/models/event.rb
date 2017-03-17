class Event < ApplicationRecord

  before_save :capitalize_event_details

  def capitalize_event_details
    self.title = self.title.camelcase
  end

  # Direct associations

  belongs_to :restaurant,
             :counter_cache => true

  has_many   :reservations,
             :dependent => :destroy

  has_many   :comments,
             :dependent => :destroy

  belongs_to :user,
             :counter_cache => true

  # Indirect associations

  has_many   :attendees,
             :through => :reservations,
             :source => :user

  has_many   :commenters,
             :through => :comments,
             :source => :user

  # Validations

end
