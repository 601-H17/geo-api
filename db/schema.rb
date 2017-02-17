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

ActiveRecord::Schema.define(version: 20170217182945) do

  create_table "admins", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.boolean  "master_admin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name",         default: ""
  end

  create_table "classrooms", force: :cascade do |t|
    t.string   "name",        default: ""
    t.string   "description", default: ""
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "floor"
    t.integer  "point_id"
  end

  add_index "classrooms", ["point_id"], name: "index_classrooms_on_point_id"

  create_table "points", force: :cascade do |t|
    t.decimal  "lat",        default: 0.0
    t.decimal  "lng",        default: 0.0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "stairs", force: :cascade do |t|
    t.string   "name"
    t.integer  "floor"
    t.integer  "point_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stairs", ["point_id"], name: "index_stairs_on_point_id"

end
