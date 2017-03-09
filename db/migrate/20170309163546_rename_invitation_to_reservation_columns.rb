class RenameInvitationToReservationColumns < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :invitations_count, :reservations_count
    rename_column :events, :invitations_count, :reservations_count
  end
end
