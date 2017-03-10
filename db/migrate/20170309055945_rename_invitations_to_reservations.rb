class RenameInvitationsToReservations < ActiveRecord::Migration[5.0]
  def change
    rename_table :invitations, :reservations
  end
end
