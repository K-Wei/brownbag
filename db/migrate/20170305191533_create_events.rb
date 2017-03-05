class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.string :host
      t.string :title
      t.text :description
      t.date :event_date
      t.time :start_time
      t.time :end_tme
      t.boolean :available
      t.integer :capacity_limit
      t.string :intent

      t.timestamps

    end
  end
end
