class AddAttributesToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :games, :string
    add_column :profiles, :accounts, :string
  end
end
