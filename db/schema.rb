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

ActiveRecord::Schema.define(version: 20140607131639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_users", id: false, force: true do |t|
    t.integer "user_id",     null: false
    t.integer "category_id", null: false
  end

  add_index "categories_users", ["category_id", "user_id"], name: "index_categories_users_on_category_id_and_user_id", using: :btree
  add_index "categories_users", ["user_id", "category_id"], name: "index_categories_users_on_user_id_and_category_id", using: :btree

  create_table "links", force: true do |t|
    t.string "name"
    t.string "url"
  end

  create_table "links_users", id: false, force: true do |t|
    t.integer "user_id", null: false
    t.integer "link_id", null: false
    t.string  "name"
  end

  add_index "links_users", ["link_id", "user_id"], name: "index_links_users_on_link_id_and_user_id", using: :btree
  add_index "links_users", ["user_id", "link_id"], name: "index_links_users_on_user_id_and_link_id", using: :btree

  create_table "statistics", force: true do |t|
    t.integer "link_id"
    t.integer "counter"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
