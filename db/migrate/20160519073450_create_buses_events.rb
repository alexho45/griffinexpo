class CreateBusesEvents < ActiveRecord::Migration
  def change
    create_table :buses_events do |t|
      t.references :bus, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
