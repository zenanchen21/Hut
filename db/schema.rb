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

ActiveRecord::Schema.define(version: 20190522192107) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "uid"
    t.string "mail"
    t.string "ou"
    t.string "dn"
    t.string "sn"
    t.string "givenname"
    t.boolean "tech"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts_trainings", force: :cascade do |t|
    t.integer "account_id"
    t.integer "training_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "audits", force: :cascade do |t|
    t.integer "account_id"
    t.integer "detail_id"
    t.string "description"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "detail_requests", force: :cascade do |t|
    t.integer "detail_id"
    t.boolean "archived_new_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "details", force: :cascade do |t|
    t.integer "equipment_id"
    t.integer "detail_id"
    t.string "vendor_name"
    t.string "vendor_contact"
    t.date "purchase_date"
    t.float "unit_cost"
    t.integer "life_expectancy"
    t.boolean "active"
    t.boolean "available"
    t.date "issue_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "location_id"
    t.integer "account_id"
    t.date "service_date"
  end

  create_table "equipment", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "expectant_expectancy"
    t.boolean "consumable"
    t.string "avatar"
    t.boolean "approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "avatar_file_cache"
    t.integer "service_rate"
  end

  create_table "equipment_pdfs", force: :cascade do |t|
    t.integer "equipment_id"
    t.integer "pdf_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipment_trainings", force: :cascade do |t|
    t.integer "equipment_id"
    t.integer "training_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lifespan_alterations", force: :cascade do |t|
    t.integer "detail_id"
    t.integer "extension"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.string "avatar_file_cache"
  end

  create_table "logs", force: :cascade do |t|
    t.integer "account_id"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pdf_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pdfs", force: :cascade do |t|
    t.string "pdf"
    t.integer "pdf_type_id"
    t.string "name"
    t.string "description"
    t.string "pdf_file_cache"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer "audit_id"
    t.text "description"
    t.text "fixing_logs"
    t.text "resolved_by"
    t.integer "urgency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_reminders", force: :cascade do |t|
    t.integer "detail_id"
    t.boolean "is_serviced"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id"
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trainings", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
