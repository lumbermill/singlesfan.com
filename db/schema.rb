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

ActiveRecord::Schema.define(version: 20150219073844) do

  create_table "events", force: true do |t|
    t.date     "opendate"
    t.integer  "opentime",     default: 1
    t.integer  "picture_id"
    t.integer  "master_id"
    t.string   "title"
    t.string   "short_desc"
    t.text     "long_desc"
    t.string   "url"
    t.integer  "submaster_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inquiries", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.date     "date"
    t.string   "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "masters", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "active",                           default: true, null: false
    t.binary   "picture",         limit: 16777215
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "broken_dishes",                    default: 0
    t.string   "job"
    t.string   "url"
    t.string   "id_facebook"
    t.string   "id_mixi"
    t.string   "id_twitter"
  end

  add_index "masters", ["email"], name: "index_masters_on_email", unique: true, using: :btree
  add_index "masters", ["name"], name: "index_masters_on_name", unique: true, using: :btree

  create_table "pictures", force: true do |t|
    t.binary   "origin",     limit: 16777215
    t.binary   "thumb",      limit: 16777215
    t.string   "desc"
    t.boolean  "active",                      default: true, null: false
    t.integer  "master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
