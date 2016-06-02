class UpdateForeignKeys < ActiveRecord::Migration
  def change
    remove_foreign_key "attendees", "companies"
    remove_foreign_key "attendees_events", "attendees"
    remove_foreign_key "attendees_events", "events"
    remove_foreign_key "buses_attendees", "attendees"
    remove_foreign_key "buses_attendees", "buses"
    remove_foreign_key "buses_events", "buses"
    remove_foreign_key "buses_events", "events"
    remove_foreign_key "companies_answers", "answers"
    remove_foreign_key "companies_answers", "companies"
    remove_foreign_key "companies_answers", "questions"
    remove_foreign_key "companies_attendees", "attendees"
    remove_foreign_key "companies_attendees", "companies"
    remove_foreign_key "companies_events", "companies"
    remove_foreign_key "companies_events", "events"
    remove_foreign_key "hotels_events", "companies"
    remove_foreign_key "hotels_events", "events"
    remove_foreign_key "hotels_events", "hotels"
    remove_foreign_key "packages_events", "companies"
    remove_foreign_key "packages_events", "events"
    remove_foreign_key "packages_events", "packages"
    remove_foreign_key "questions_answers", "answers"
    remove_foreign_key "questions_answers", "questions"
    remove_foreign_key "questions_events", "events"
    remove_foreign_key "questions_events", "questions"

    add_foreign_key "attendees", "companies", on_delete: :cascade
    add_foreign_key "attendees_events", "attendees", on_delete: :cascade
    add_foreign_key "attendees_events", "events", on_delete: :cascade
    add_foreign_key "buses_attendees", "attendees", on_delete: :cascade
    add_foreign_key "buses_attendees", "buses", on_delete: :cascade
    add_foreign_key "buses_events", "buses", on_delete: :cascade
    add_foreign_key "buses_events", "events", on_delete: :cascade
    add_foreign_key "companies_answers", "answers", on_delete: :cascade
    add_foreign_key "companies_answers", "companies", on_delete: :cascade
    add_foreign_key "companies_answers", "questions", on_delete: :cascade
    add_foreign_key "companies_attendees", "attendees", on_delete: :cascade
    add_foreign_key "companies_attendees", "companies", on_delete: :cascade
    add_foreign_key "companies_events", "companies", on_delete: :cascade
    add_foreign_key "companies_events", "events", on_delete: :cascade
    add_foreign_key "hotels_events", "companies", on_delete: :cascade
    add_foreign_key "hotels_events", "events", on_delete: :cascade
    add_foreign_key "hotels_events", "hotels", on_delete: :cascade
    add_foreign_key "packages_events", "companies", on_delete: :cascade
    add_foreign_key "packages_events", "events", on_delete: :cascade
    add_foreign_key "packages_events", "packages", on_delete: :cascade
    add_foreign_key "questions_answers", "answers", on_delete: :cascade
    add_foreign_key "questions_answers", "questions", on_delete: :cascade
    add_foreign_key "questions_events", "events", on_delete: :cascade
    add_foreign_key "questions_events", "questions", on_delete: :cascade
  end
end
