class AddHostToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :host, :integer
  end
end
