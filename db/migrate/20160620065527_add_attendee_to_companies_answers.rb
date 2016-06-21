class AddAttendeeToCompaniesAnswers < ActiveRecord::Migration
  def change
    add_reference :companies_answers, :attendee
    add_foreign_key "companies_answers", "attendees", on_delete: :cascade
  end
end
