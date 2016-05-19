class CreateAttendeesEvents < ActiveRecord::Migration
  def change
    create_table :attendees_events do |t|
      t.references :attendee, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
