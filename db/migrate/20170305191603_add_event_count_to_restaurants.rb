class AddEventCountToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :events_count, :integer
  end
end
