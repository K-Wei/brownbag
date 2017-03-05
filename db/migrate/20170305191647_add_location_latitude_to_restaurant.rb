class AddLocationLatitudeToRestaurant < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :location_latitude, :float
  end
end
