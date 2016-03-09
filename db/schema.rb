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

ActiveRecord::Schema.define(version: 20160308220833) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "album_reviews", force: :cascade do |t|
    t.integer "album_id"
    t.integer "review_id"
  end

  add_index "album_reviews", ["album_id"], name: "index_album_reviews_on_album_id", using: :btree
  add_index "album_reviews", ["review_id"], name: "index_album_reviews_on_review_id", using: :btree

  create_table "albums", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "image_url"
    t.string   "release_year"
    t.integer  "price"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "genre_id"
    t.integer  "artist_id"
    t.string   "slug"
  end

  add_index "albums", ["artist_id"], name: "index_albums_on_artist_id", using: :btree
  add_index "albums", ["genre_id"], name: "index_albums_on_genre_id", using: :btree
  add_index "albums", ["slug"], name: "index_albums_on_slug", using: :btree

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.string   "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "artists", ["slug"], name: "index_artists_on_slug", using: :btree

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "genres", ["slug"], name: "index_genres_on_slug", using: :btree

  create_table "order_albums", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "album_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_albums", ["album_id"], name: "index_order_albums_on_album_id", using: :btree
  add_index "order_albums", ["order_id"], name: "index_order_albums_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "total"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "role",            default: 0
  end

  add_foreign_key "album_reviews", "albums"
  add_foreign_key "album_reviews", "reviews"
  add_foreign_key "albums", "artists"
  add_foreign_key "albums", "genres"
  add_foreign_key "order_albums", "albums"
  add_foreign_key "order_albums", "orders"
  add_foreign_key "orders", "users"
end
