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

ActiveRecord::Schema.define(version: 20130516093855) do

  create_table "categories", force: true do |t|
    t.string   "category_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.string   "text"
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "picture_id"
  end

  add_index "comments", ["picture_id"], name: "index_comments_on_picture_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "countries", force: true do |t|
    t.string   "country_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "friend_id"
  end

  add_index "friendships", ["user_id"], name: "index_friendships_on_user_id"

  create_table "likes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "picture_id"
    t.integer  "user_id"
  end

  add_index "likes", ["picture_id"], name: "index_likes_on_picture_id"
  add_index "likes", ["user_id"], name: "index_likes_on_user_id"

  create_table "pictures", force: true do |t|
    t.string   "picture_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "country_id"
    t.integer  "category_id"
  end

  add_index "pictures", ["category_id"], name: "index_pictures_on_category_id"
  add_index "pictures", ["country_id"], name: "index_pictures_on_country_id"
  add_index "pictures", ["user_id"], name: "index_pictures_on_user_id"

  create_table "timelines", force: true do |t|
    t.string   "text"
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "picture_id"
  end

  add_index "timelines", ["picture_id"], name: "index_timelines_on_picture_id"
  add_index "timelines", ["user_id"], name: "index_timelines_on_user_id"

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "profileImage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
