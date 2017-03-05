class Event < ApplicationRecord
  # Direct associations

  has_many   :invitations,
             :dependent => :destroy

  has_many   :comments,
             :dependent => :destroy

  belongs_to :user,
             :counter_cache => true

  # Indirect associations

  # Validations

end
