class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :description
      t.string :name
      t.string :date
      t.string :time

      t.timestamps
    end
  end
end
