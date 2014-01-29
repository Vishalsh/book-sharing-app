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

ActiveRecord::Schema.define(version: 20140128114344) do

  create_table "book_borrowers", force: true do |t|
    t.integer  "book_id"
    t.integer  "owner_id"
    t.integer  "borrower_id"
    t.string   "date_of_borrowing"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "isbn"
    t.integer  "edition"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "author"
    t.string   "image_url"
  end

  create_table "books_owners", id: false, force: true do |t|
    t.integer "book_id", null: false
    t.integer "user_id", null: false
  end

  create_table "books_tags", id: false, force: true do |t|
    t.integer "book_id"
    t.integer "tag_id"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
