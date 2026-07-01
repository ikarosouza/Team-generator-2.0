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

ActiveRecord::Schema[8.1].define(version: 2026_07_01_000100) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "athletes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "guest"
    t.integer "level"
    t.string "name"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_athletes_on_user_id"
  end

  create_table "pickup_game_athletes", force: :cascade do |t|
    t.bigint "athlete_id", null: false
    t.datetime "created_at", null: false
    t.bigint "pickup_game_id", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_id"], name: "index_pickup_game_athletes_on_athlete_id"
    t.index ["pickup_game_id"], name: "index_pickup_game_athletes_on_pickup_game_id"
  end

  create_table "pickup_games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "duration"
    t.datetime "start_at"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_pickup_games_on_user_id"
  end

  create_table "team_generations", force: :cascade do |t|
    t.jsonb "bench_payload", default: [], null: false
    t.datetime "created_at", null: false
    t.jsonb "selected_athlete_ids", default: [], null: false
    t.integer "team_size", null: false
    t.jsonb "teams_payload", default: [], null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "created_at"], name: "index_team_generations_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_team_generations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "athletes", "users"
  add_foreign_key "pickup_game_athletes", "athletes"
  add_foreign_key "pickup_game_athletes", "pickup_games"
  add_foreign_key "pickup_games", "users"
  add_foreign_key "team_generations", "users"
end
