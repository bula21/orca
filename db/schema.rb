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

ActiveRecord::Schema.define(version: 2019_11_18_113425) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "al_id", null: false
    t.bigint "lagerleiter_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["al_id"], name: "index_units_on_al_id"
    t.index ["lagerleiter_id"], name: "index_units_on_lagerleiter_id"
  end

  add_foreign_key "units", "leaders", column: "al_id"
  add_foreign_key "units", "leaders", column: "lagerleiter_id"
end
