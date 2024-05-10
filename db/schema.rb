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

ActiveRecord::Schema[7.0].define(version: 2024_05_10_165651) do
  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.string "photo"
    t.date "birth_year"
    t.string "country"
    t.integer "user_artist_id"
    t.integer "inspiration_id"
    t.boolean "visibility"
    t.integer "artworks_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artworks", force: :cascade do |t|
    t.string "title"
    t.string "photo"
    t.string "description"
    t.date "year"
    t.string "location"
    t.integer "artist_id"
    t.integer "style_id"
    t.integer "inspiration_id"
    t.integer "project_id"
    t.boolean "visibility"
    t.integer "likes_count"
    t.integer "comments_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "user_id"
    t.integer "artwork_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "follows", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "sender_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inspirations", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "other_notes"
    t.integer "user_id"
    t.boolean "visibility"
    t.integer "projects_count"
    t.integer "artists_count"
    t.integer "artworks_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "artwork_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.string "completed_photo"
    t.text "desription"
    t.string "status"
    t.date "start_date"
    t.date "finish_date"
    t.text "other_notes"
    t.integer "user_id"
    t.integer "inspiration_id"
    t.integer "artworks_count"
    t.integer "updates_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "styles", force: :cascade do |t|
    t.string "name"
    t.integer "artworks_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "updates", force: :cascade do |t|
    t.string "photo"
    t.text "body"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "photo"
    t.date "birth_year"
    t.string "country"
    t.boolean "visibility"
    t.integer "likes_count"
    t.integer "comments_count"
    t.integer "received_follows_count"
    t.integer "sent_follows_count"
    t.integer "own_artists_count"
    t.integer "projects_count"
    t.integer "inspirations_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
