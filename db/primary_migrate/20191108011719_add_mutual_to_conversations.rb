class AddMutualToConversations < ActiveRecord::Migration[6.0]
  def change
    add_column :conversations, :mutual, :boolean, default: false
  end
end
