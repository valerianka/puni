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

ActiveRecord::Schema[7.2].define(version: 20_260_331_000_000) do
  create_table 'munis', force: :cascade do |t|
    t.datetime 'created_at', precision: nil, null: false
    t.datetime 'updated_at', precision: nil, null: false
    t.string 'route_name', null: false
    t.integer 'avg_smell_rating', default: 1
    t.integer 'avg_clean_rating', default: 1
    t.integer 'avg_driver_rating', default: 1
    t.index ['route_name'], name: 'index_munis_on_route_name', unique: true
  end

  create_table 'reports', force: :cascade do |t|
    t.datetime 'created_at', precision: nil, null: false
    t.datetime 'updated_at', precision: nil, null: false
    t.integer 'smell_rating', null: false
    t.integer 'clean_rating', null: false
    t.integer 'driver_rating', null: false
    t.integer 'muni_id', null: false
    t.index ['muni_id'], name: 'index_reports_on_muni_id'
  end

  create_table 'stories', force: :cascade do |t|
    t.datetime 'created_at', precision: nil, null: false
    t.datetime 'updated_at', precision: nil, null: false
    t.text 'content', null: false
    t.string 'img_url'
    t.integer 'report_id', null: false
    t.index ['report_id'], name: 'index_stories_on_report_id'
  end
end
