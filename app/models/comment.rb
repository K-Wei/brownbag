class Comment < ApplicationRecord
  # Direct associations

  belongs_to :event,
             :counter_cache => true

  belongs_to :user

  # Indirect associations

  # Validations

end
