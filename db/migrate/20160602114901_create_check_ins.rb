class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.references :attendee, index: true
      t.references :event, index: true
      t.string :seminar

      t.timestamps null: false
    end
    add_foreign_key "check_ins", "attendees", on_delete: :cascade
    add_foreign_key "check_ins", "events", on_delete: :cascade
  end
end
