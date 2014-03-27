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

ActiveRecord::Schema.define(version: 20140327051021) do

  create_table "comments", force: true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "embedded_url"
    t.string   "slug"
    t.string   "favicon_url"
    t.string   "author_name"
    t.string   "author_url"
    t.string   "provider_name"
    t.string   "provider_url"
    t.string   "thumbnail_url"
    t.string   "thumbnail_width"
    t.string   "thumbnail_height"
    t.string   "width"
    t.string   "height"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "language"
    t.integer  "up_votes"
    t.integer  "down_votes"
    t.string   "youtube_video_id"
  end

  create_table "users", force: true do |t|
    t.string   "user_name"
    t.string   "password_digest"
    t.string   "slug"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.string   "oauth_expires_at"
    t.string   "email"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url"
  end

  create_table "votes", force: true do |t|
    t.boolean  "vote"
    t.integer  "user_id"
    t.integer  "voteable_id"
    t.string   "voteable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
