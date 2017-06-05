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

ActiveRecord::Schema.define(version: 20160917115925) do

  create_table "games", force: :cascade do |t|
    t.integer "activ_rally_id"
    t.integer "phase"
  end

  create_table "microposts", force: :cascade do |t|
    t.integer  "points"
    t.integer  "unit_points"
    t.boolean  "ballon"
    t.integer  "station_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "picture"
    t.integer  "team_id"
  end

  add_index "microposts", ["station_id", "created_at"], name: "index_microposts_on_station_id_and_created_at"
  add_index "microposts", ["station_id"], name: "index_microposts_on_station_id"
  add_index "microposts", ["team_id"], name: "index_microposts_on_team_id"

  create_table "rallies", force: :cascade do |t|
    t.text     "name"
    t.string   "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "station_id"
  end

  add_index "rallies", ["station_id"], name: "index_rallies_on_station_id"

  create_table "stations", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "picture"
    t.string   "phone"
    t.string   "rules"
    t.string   "unit"
    t.boolean  "high_better"
    t.boolean  "news"
    t.boolean  "news_for_user"
    t.string   "beer_status"
    t.string   "erstis_status"
    t.string   "station_status"
    t.string   "chat_status"
    t.time     "clock1"
    t.boolean  "clock1_running"
    t.time     "clock2"
    t.boolean  "clock2_running"
    t.string   "question"
    t.string   "answer"
    t.integer  "rally_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin"
  end

  create_table "teams", force: :cascade do |t|
    t.text     "name"
    t.string   "picture"
    t.integer  "station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "rally_id"
  end

  add_index "teams", ["rally_id"], name: "index_teams_on_rally_id"
  add_index "teams", ["station_id"], name: "index_teams_on_station_id"

end
