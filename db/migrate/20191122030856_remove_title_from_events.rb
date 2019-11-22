class RemoveTitleFromEvents < ActiveRecord::Migration[6.0]
  def change

    remove_column :events, :title, :string
  end
end
