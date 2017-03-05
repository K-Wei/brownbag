class Event < ApplicationRecord
  # Direct associations

  belongs_to :restaurant,
             :counter_cache => true

  has_many   :invitations,
             :dependent => :destroy

  has_many   :comments,
             :dependent => :destroy

  belongs_to :user,
             :counter_cache => true

  # Indirect associations

  has_many   :attendees,
             :through => :invitations,
             :source => :user

  has_many   :commenters,
             :through => :comments,
             :source => :user

  # Validations

end
