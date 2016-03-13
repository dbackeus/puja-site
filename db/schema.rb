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

ActiveRecord::Schema.define(version: 20160313105453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "participants", force: :cascade do |t|
    t.string   "name"
    t.string   "gender"
    t.string   "age"
    t.integer  "registration_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "participants", ["registration_id"], name: "index_participants_on_registration_id", using: :btree

  create_table "registrations", force: :cascade do |t|
    t.string   "email"
    t.string   "phone"
    t.boolean  "transport"
    t.string   "country"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "accommodation"
    t.string   "registration_type"
    t.float    "extra"
    t.boolean  "paid",               default: false, null: false
    t.string   "stripe_customer_id"
    t.string   "stripe_charge_id"
    t.string   "stripe_token"
    t.string   "token"
    t.text     "comment"
  end

  add_index "registrations", ["token"], name: "index_registrations_on_token", unique: true, using: :btree

  add_foreign_key "participants", "registrations"
end
