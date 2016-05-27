# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160527095110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "answers", force: :cascade do |t|
    t.string   "value"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attendees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "attendees", ["company_id"], name: "index_attendees_on_company_id", using: :btree

  create_table "attendees_events", force: :cascade do |t|
    t.integer  "attendee_id"
    t.integer  "event_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "attendees_events", ["attendee_id"], name: "index_attendees_events_on_attendee_id", using: :btree
  add_index "attendees_events", ["event_id"], name: "index_attendees_events_on_event_id", using: :btree

  create_table "buses", force: :cascade do |t|
    t.integer  "seats_limit"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "buses_attendees", force: :cascade do |t|
    t.integer  "bus_id"
    t.integer  "attendee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "buses_attendees", ["attendee_id"], name: "index_buses_attendees_on_attendee_id", using: :btree
  add_index "buses_attendees", ["bus_id"], name: "index_buses_attendees_on_bus_id", using: :btree

  create_table "buses_events", force: :cascade do |t|
    t.integer  "bus_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "buses_events", ["bus_id"], name: "index_buses_events_on_bus_id", using: :btree
  add_index "buses_events", ["event_id"], name: "index_buses_events_on_event_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "registrant"
    t.string   "address"
    t.string   "representative_email"
    t.string   "representative_phone"
    t.integer  "company_type"
    t.string   "access_token"
    t.integer  "payment_status"
    t.integer  "payment_type"
    t.string   "confirmation_token"
    t.integer  "process_step"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "companies_answers", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "answer_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "companies_answers", ["answer_id"], name: "index_companies_answers_on_answer_id", using: :btree
  add_index "companies_answers", ["company_id"], name: "index_companies_answers_on_company_id", using: :btree
  add_index "companies_answers", ["question_id"], name: "index_companies_answers_on_question_id", using: :btree

  create_table "companies_attendees", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "attendee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "companies_attendees", ["attendee_id"], name: "index_companies_attendees_on_attendee_id", using: :btree
  add_index "companies_attendees", ["company_id"], name: "index_companies_attendees_on_company_id", using: :btree

  create_table "companies_events", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "companies_events", ["company_id"], name: "index_companies_events_on_company_id", using: :btree
  add_index "companies_events", ["event_id"], name: "index_companies_events_on_event_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.date     "from"
    t.date     "to"
    t.string   "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hotels", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hotels_events", force: :cascade do |t|
    t.integer  "hotel_id"
    t.integer  "event_id"
    t.integer  "company_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "hotels_events", ["company_id"], name: "index_hotels_events_on_company_id", using: :btree
  add_index "hotels_events", ["event_id"], name: "index_hotels_events_on_event_id", using: :btree
  add_index "hotels_events", ["hotel_id"], name: "index_hotels_events_on_hotel_id", using: :btree

  create_table "packages", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "packages_events", force: :cascade do |t|
    t.integer  "package_id"
    t.integer  "event_id"
    t.integer  "company_id"
    t.integer  "quantity"
    t.boolean  "electricity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "packages_events", ["company_id"], name: "index_packages_events_on_company_id", using: :btree
  add_index "packages_events", ["event_id"], name: "index_packages_events_on_event_id", using: :btree
  add_index "packages_events", ["package_id"], name: "index_packages_events_on_package_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.boolean  "text_field", default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "questions_answers", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "questions_answers", ["answer_id"], name: "index_questions_answers_on_answer_id", using: :btree
  add_index "questions_answers", ["question_id"], name: "index_questions_answers_on_question_id", using: :btree

  create_table "questions_events", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "event_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "questions_events", ["event_id"], name: "index_questions_events_on_event_id", using: :btree
  add_index "questions_events", ["question_id"], name: "index_questions_events_on_question_id", using: :btree

  add_foreign_key "attendees", "companies"
  add_foreign_key "attendees_events", "attendees"
  add_foreign_key "attendees_events", "events"
  add_foreign_key "buses_attendees", "attendees"
  add_foreign_key "buses_attendees", "buses"
  add_foreign_key "buses_events", "buses"
  add_foreign_key "buses_events", "events"
  add_foreign_key "companies_answers", "answers"
  add_foreign_key "companies_answers", "companies"
  add_foreign_key "companies_answers", "questions"
  add_foreign_key "companies_attendees", "attendees"
  add_foreign_key "companies_attendees", "companies"
  add_foreign_key "companies_events", "companies"
  add_foreign_key "companies_events", "events"
  add_foreign_key "hotels_events", "companies"
  add_foreign_key "hotels_events", "events"
  add_foreign_key "hotels_events", "hotels"
  add_foreign_key "packages_events", "companies"
  add_foreign_key "packages_events", "events"
  add_foreign_key "packages_events", "packages"
  add_foreign_key "questions_answers", "answers"
  add_foreign_key "questions_answers", "questions"
  add_foreign_key "questions_events", "events"
  add_foreign_key "questions_events", "questions"
end
