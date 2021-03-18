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

ActiveRecord::Schema.define(version: 2021_03_14_162423) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "duties", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_general", default: false
    t.boolean "write_all", default: true
  end

  create_table "duties_users", force: :cascade do |t|
    t.bigint "duty_id"
    t.bigint "user_id"
    t.boolean "has_write_access", default: true
    t.index ["duty_id"], name: "index_duties_users_on_duty_id"
    t.index ["user_id"], name: "index_duties_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "mail"
    t.text "password_digest"
    t.datetime "birth_date"
    t.boolean "is_admin", default: false
    t.integer "rating", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", default: ""
    t.string "surname", default: ""
    t.string "patronymic", default: ""
    t.datetime "restore_date", default: "2021-02-11 09:57:14"
    t.boolean "is_boss", default: false
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "vote_type", default: 0
    t.text "body"
    t.string "title"
    t.datetime "active_to"
    t.text "iter_array", default: "[]"
    t.integer "current_iter", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "vote_status", default: 0
    t.bigint "duty_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
