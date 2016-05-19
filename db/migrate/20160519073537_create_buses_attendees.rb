class CreateBusesAttendees < ActiveRecord::Migration
  def change
    create_table :buses_attendees do |t|
      t.references :bus, index: true, foreign_key: true
      t.references :attendee, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
