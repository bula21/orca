# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_07_132248) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invoice_parts", force: :cascade do |t|
    t.bigint "invoice_id", null: false
    t.string "type"
    t.decimal "amount"
    t.string "label"
    t.string "breakdown"
    t.integer "ordinal"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invoice_id"], name: "index_invoice_parts_on_invoice_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "unit_id", null: false
    t.string "type"
    t.date "issued_at", default: -> { "CURRENT_TIMESTAMP" }
    t.date "payable_until"
    t.datetime "sent_at"
    t.text "text"
    t.text "invoice_address"
    t.string "ref"
    t.decimal "amount", default: "0.0"
    t.boolean "paid", default: false
    t.string "payment_info_type"
    t.integer "category", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["unit_id"], name: "index_invoices_on_unit_id"
  end

  create_table "leaders", force: :cascade do |t|
    t.integer "pbs_id"
    t.string "last_name"
    t.string "first_name"
    t.string "scout_name"
    t.date "birthdate"
    t.string "gender"
    t.string "email"
    t.string "phone_number"
    t.string "language"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "address"
    t.string "zip_code"
    t.string "town"
    t.string "country"
  end

  create_table "units", force: :cascade do |t|
    t.integer "pbs_id"
    t.string "title"
    t.string "abteilung"
    t.integer "kv"
    t.string "stufe"
    t.integer "expected_participants_f"
    t.integer "expected_participants_m"
    t.integer "expected_participants_leitung_f"
    t.integer "expected_participants_leitung_m"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.bigint "lagerleiter_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "al_id"
    t.bigint "coach_id"
    t.jsonb "midata_data"
    t.string "limesurvey_token"
    t.index ["al_id"], name: "index_units_on_al_id"
    t.index ["coach_id"], name: "index_units_on_coach_id"
    t.index ["lagerleiter_id"], name: "index_units_on_lagerleiter_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "pbs_id"
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "invoice_parts", "invoices"
  add_foreign_key "invoices", "units"
  add_foreign_key "units", "leaders", column: "al_id"
  add_foreign_key "units", "leaders", column: "coach_id"
  add_foreign_key "units", "leaders", column: "lagerleiter_id"
end
