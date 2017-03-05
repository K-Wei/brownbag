class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :location
      t.string :yelp_url
      t.string :price
      t.text :categories
      t.string :picture_url

      t.timestamps

    end
  end
end
