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

ActiveRecord::Schema.define(version: 20170527094351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.string   "send_from"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mailing_templates", force: :cascade do |t|
    t.integer  "game_id"
    t.string   "subject"
    t.string   "text"
    t.integer  "status",                default: 0,    null: false
    t.datetime "planing_start_time_at"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.json     "filters",               default: "{}", null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["game_id"], name: "index_mailing_templates_on_game_id", using: :btree
  end

  create_table "mails", force: :cascade do |t|
    t.integer  "mailing_template_id"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["mailing_template_id"], name: "index_mails_on_mailing_template_id", using: :btree
    t.index ["user_id"], name: "index_mails_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "level"
    t.datetime "last_visit_at"
    t.boolean  "payed",         default: false, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "game_id"
    t.index ["game_id"], name: "index_users_on_game_id", using: :btree
  end

end
