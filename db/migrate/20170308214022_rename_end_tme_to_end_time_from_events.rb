class RenameEndTmeToEndTimeFromEvents < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :end_tme, :end_time
  end
end
