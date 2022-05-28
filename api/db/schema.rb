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

ActiveRecord::Schema[7.0].define(version: 0) do
  create_table "comics", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "title", null: false
    t.string "copyright_title", null: false
    t.text "author", size: :medium, null: false
    t.integer "imprint_id"
    t.integer "publisher_id"
    t.integer "year_start"
    t.integer "year_end"
    t.integer "total_volumes"
    t.boolean "ongoing"
    t.boolean "hiatus"
    t.integer "original_status"
    t.integer "publishing_status"
    t.string "thumbnail"
    t.string "age"
    t.string "paper_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "covers", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "comic_id", null: false
    t.integer "volume", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "elements", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.string "selector_type", default: "css", null: false
    t.string "selector_path", null: false
    t.string "image", null: false
    t.integer "screen_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "comic_id", null: false
    t.integer "volume", null: false
    t.integer "price"
    t.integer "quantity", default: 1
    t.boolean "is_bundle", default: false
    t.integer "bundle_volume_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "provider_id", null: false
    t.string "order_number", null: false
    t.decimal "total", precision: 10, default: "0"
    t.decimal "shipping_fee", precision: 10, default: "0"
    t.decimal "paid", precision: 10, default: "0"
    t.datetime "ordered_at"
    t.datetime "arriving_at"
    t.datetime "arrived_at"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "providers", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.string "logo"
    t.string "url", null: false
    t.integer "user_id"
    t.text "script"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publishers", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.string "logo"
    t.string "country"
    t.string "image"
    t.boolean "is_imprint"
    t.boolean "is_publisher"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "run_histories", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "test_case_id"
    t.integer "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scenarios", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.text "steps", size: :medium, null: false
    t.integer "project_id", null: false
    t.integer "scenario_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "screens", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.integer "project_id", null: false
    t.string "url", null: false
    t.integer "auth_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_cases", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.text "url", null: false
    t.integer "screen_id", null: false
    t.text "steps", size: :medium, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "upcomings", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.date "date", null: false
    t.integer "comic_id", null: false
    t.integer "volume"
    t.integer "combo"
    t.boolean "official"
    t.datetime "grabbed_at"
    t.datetime "skipped_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_comics", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "comic_id", null: false
    t.boolean "follow"
    t.integer "rate"
    t.integer "read"
    t.integer "collected"
    t.datetime "last_collected_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "comic_id"], name: "index_user_comics_on_user_id_and_comic_id", unique: true
  end

  create_table "user_volumes", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "comic_id", null: false
    t.integer "volume", null: false
    t.datetime "collected_at"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "comic_id", "volume"], name: "index_user_volumes_on_user_id_and_comic_id_and_volume", unique: true
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "username", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "role", default: "member", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "volumes", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "comic_id", null: false
    t.integer "volume", null: false
    t.string "cover"
    t.date "release_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comic_id", "volume"], name: "index_volumes_on_comic_id_and_volume", unique: true
  end

end
