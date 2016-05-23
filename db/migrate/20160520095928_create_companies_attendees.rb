class CreateCompaniesAttendees < ActiveRecord::Migration
  def change
    create_table :companies_attendees do |t|
      t.references :company, index: true, foreign_key: true
      t.references :attendee, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
