class Restaurant < ApplicationRecord
  before_validation :geocode_location
  before_save :capitalize_restaurant_details

  def capitalize_restaurant_details
    self.name = name.camelcase
    self.location = location.camelcase
    self.categories = categories.camelcase
  end

  def geocode_location
    if self.location.present?
      url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{URI.encode(self.location)}"

      raw_data = open(url).read

      parsed_data = JSON.parse(raw_data)

      if parsed_data["results"].present?
        self.location_latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

        self.location_longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

        self.location_formatted_address = parsed_data["results"][0]["formatted_address"]
      end
    end
  end
  # Direct associations

  has_many   :events,
             :dependent => :destroy

  # Indirect associations

  # Validations
  validates :name, :presence => true
  validates :location, format: { with: /\d*\s\w*(.+),\s\w*,\s\w\w\s\w*/}
  validates :yelp_url, format: { with: /https:\/\/www.yelp.com\/biz\/\S*/}
  validates :price, :presence => true, format: { with: /[$]/}
  validates :categories, :presence => true

  def name_with_address
    return self.name + " (" + self.location + ")"

  end
end
