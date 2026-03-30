# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# The contents of this file are used to recreate the database on another system.
# Use "bin/rails db:schema:load", not running all the migrations, when recreating from scratch.
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 20160301053517) do

  create_table "munis", force: :cascade do |t|
    t.datetime "created_at",                    null: false 
    t.datetime "updated_at",                    null: false
    t.string   "route_name",                    null: false
    t.integer  "avg_smell_rating",  default: 1
    t.integer  "avg_clean_rating",  default: 1
    t.integer  "avg_driver_rating", default: 1
  end

  create_table "reports", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "smell_rating",  null: false
    t.integer  "clean_rating",  null: false
    t.integer  "driver_rating", null: false
    t.integer  "muni_id",       null: false
  end

  add_index "reports", ["muni_id"], name: "index_reports_on_muni_id"

  create_table "stories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "content",    null: false
    t.string   "img_url"
    t.integer  "report_id",  null: false
  end

  add_index "stories", ["report_id"], name: "index_stories_on_report_id"

end
