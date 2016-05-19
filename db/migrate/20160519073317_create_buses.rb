class CreateBuses < ActiveRecord::Migration
  def change
    create_table :buses do |t|
      t.integer :seats_limit

      t.timestamps null: false
    end
  end
end
