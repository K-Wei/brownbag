class AddLocationFormattedAddressToRestaurant < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :location_formatted_address, :string
  end
end
