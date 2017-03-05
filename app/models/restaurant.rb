class Restaurant < ApplicationRecord
  # Direct associations

  has_many   :events,
             :dependent => :destroy

  # Indirect associations

  # Validations

end
