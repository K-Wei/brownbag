class AddInvitationCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :invitations_count, :integer
  end
end
