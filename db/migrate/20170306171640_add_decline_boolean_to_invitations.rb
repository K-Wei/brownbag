class AddDeclineBooleanToInvitations < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :declined, :boolean
  end
end
