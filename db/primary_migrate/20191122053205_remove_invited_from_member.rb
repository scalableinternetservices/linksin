class RemoveInvitedFromMember < ActiveRecord::Migration[6.0]
  def change

    remove_column :members, :is_invited, :boolean
  end
end
