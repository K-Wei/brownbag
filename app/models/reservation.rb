class Reservation < ApplicationRecord
  # Direct associations

  belongs_to :event,
             :counter_cache => true

  belongs_to :user,
             :counter_cache => true

  # Indirect associations

  # Validations

end
