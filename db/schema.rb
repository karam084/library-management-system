# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_01_01_000928) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.integer "student_id"
    t.integer "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "isbn"
    t.string "title"
    t.string "authors"
    t.string "language"
    t.string "published"
    t.string "edition"
    t.string "subject"
    t.text "summary"
    t.string "category"
    t.boolean "special_collection"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "count"
  end

  create_table "checkouts", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.date "issue_date"
    t.date "return_date"
    t.integer "validity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_checkouts_on_book_id"
  end

  create_table "hold_requests", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_hold_requests_on_book_id"
  end

  create_table "librarians", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.string "library"
    t.string "approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.string "university"
    t.string "location"
    t.integer "borrow_limit"
    t.float "overdue_fines"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "special_books", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_special_books_on_book_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password"
    t.string "education_level"
    t.string "university"
    t.integer "max_book_allowed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "google_token"
    t.string "google_refresh_token"
    t.string "provider"
    t.string "uid"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "isbn"
    t.string "email"
    t.boolean "checkout"
    t.boolean "request"
    t.boolean "bookmarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "universities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "checkouts", "books"
  add_foreign_key "hold_requests", "books"
  add_foreign_key "special_books", "books"
end
