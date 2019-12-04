class AddInviteeToMember < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :is_invited, :boolean
  end
end
