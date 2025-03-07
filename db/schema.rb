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

ActiveRecord::Schema[8.0].define(version: 2024_01_01_000004) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "form_fields", force: :cascade do |t|
    t.bigint "form_id", null: false
    t.string "field_type", null: false
    t.string "label", null: false
    t.text "description"
    t.boolean "required", default: false
    t.integer "position"
    t.jsonb "options", default: {}
    t.jsonb "translations", default: {}
    t.jsonb "validations", default: {}
    t.jsonb "accessibility_attributes", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_form_fields_on_form_id"
  end

  create_table "form_submissions", force: :cascade do |t|
    t.bigint "form_id", null: false
    t.bigint "user_id"
    t.jsonb "data", default: {}
    t.string "status", default: "submitted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_form_submissions_on_form_id"
    t.index ["user_id"], name: "index_form_submissions_on_user_id"
  end

  create_table "forms", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.boolean "active", default: true
    t.bigint "user_id", null: false
    t.jsonb "translations", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_forms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name"
    t.string "role", default: "provider"
    t.string "preferred_language", default: "en"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "form_fields", "forms"
  add_foreign_key "form_submissions", "forms"
  add_foreign_key "form_submissions", "users"
  add_foreign_key "forms", "users"
end
