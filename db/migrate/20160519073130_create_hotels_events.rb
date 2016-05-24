class CreateHotelsEvents < ActiveRecord::Migration
  def change
    create_table :hotels_events do |t|
      t.references :hotel, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      t.references :company, index: true, foreign_key: true
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
