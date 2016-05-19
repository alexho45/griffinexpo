class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.date :from
      t.date :to
      t.string :location

      t.timestamps null: false
    end
  end
end
