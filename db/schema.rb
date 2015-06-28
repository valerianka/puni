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

ActiveRecord::Schema.define(version: 20150628002331) do

  create_table "munis", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "route_name"
  end

  create_table "reports", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "smell_rating"
    t.integer  "clean_rating"
    t.integer  "driver_rating"
    t.integer  "muni_id"
  end

  add_index "reports", ["muni_id"], name: "index_reports_on_muni_id"

  create_table "stories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "content"
    t.string   "img_url"
    t.integer  "report_id"
  end

  add_index "stories", ["report_id"], name: "index_stories_on_report_id"

end
