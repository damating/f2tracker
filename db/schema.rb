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

ActiveRecord::Schema.define(version: 20151023192404) do

  create_table "badges", force: :cascade do |t|
    t.string   "name"
    t.integer  "points_limit"
    t.string   "icon"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "matches", force: :cascade do |t|
    t.string   "title"
    t.date     "date"
    t.time     "startTime"
    t.integer  "player1_id"
    t.integer  "player2_id"
    t.integer  "winner"
    t.integer  "player1_goals"
    t.integer  "player2_goals"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "role"
    t.integer  "wins"
    t.integer  "losts"
    t.integer  "points"
    t.integer  "goals"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "badge_id"
  end

  add_index "players", ["badge_id"], name: "index_players_on_badge_id"

end
