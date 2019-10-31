class DropMicroposts < ActiveRecord::Migration[6.0]
  def change
    drop_table :microposts
  end
end
