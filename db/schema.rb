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

ActiveRecord::Schema.define(version: 20160609090738) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "donations", force: :cascade do |t|
    t.integer  "amount"
    t.string   "stripe_customer_id"
    t.string   "stripe_charge_id"
    t.string   "stripe_token"
    t.string   "email"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "participants", force: :cascade do |t|
    t.string   "name"
    t.string   "gender"
    t.string   "age"
    t.integer  "registration_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["registration_id"], name: "index_participants_on_registration_id", using: :btree
  end

  create_table "registrations", force: :cascade do |t|
    t.string   "email"
    t.string   "phone"
    t.boolean  "transport"
    t.string   "country"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "accommodation"
    t.string   "registration_type"
    t.float    "extra"
    t.boolean  "paid",                    default: false, null: false
    t.string   "stripe_customer_id"
    t.string   "stripe_charge_id"
    t.string   "stripe_token"
    t.string   "token"
    t.text     "comment"
    t.string   "ip_address"
    t.datetime "arrival_at"
    t.datetime "departure_at"
    t.string   "arrival_flight_no"
    t.string   "departure_flight_no"
    t.datetime "transport_registered_at"
    t.index ["token"], name: "index_registrations_on_token", unique: true, using: :btree
  end

  add_foreign_key "participants", "registrations"
end
