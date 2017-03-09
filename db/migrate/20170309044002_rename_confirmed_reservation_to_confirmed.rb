class RenameConfirmedReservationToConfirmed < ActiveRecord::Migration[5.0]
  def change
    rename_column :invitations, :confirmed_reservation, :confirmed
  end
end
