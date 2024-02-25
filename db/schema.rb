# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_02_25_070625) do
  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "last_name"
    t.string "department"
    t.string "employee_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "works", force: :cascade do |t|
    t.time "start_time"
    t.time "end_time"
    t.text "comment"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "total_hours"
    t.date "date"
    t.time "break_time"
    t.index ["user_id", "created_at"], name: "index_works_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_works_on_user_id"
  end

  add_foreign_key "works", "users"
end
