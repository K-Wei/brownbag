class AddInvitationCountToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :invitations_count, :integer
  end
end
