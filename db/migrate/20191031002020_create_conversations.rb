class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.integer :send_id
      t.integer :recv_id

      t.timestamps
    end
  end
end
