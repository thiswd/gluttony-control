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

ActiveRecord::Schema[7.0].define(version: 2023_09_19_195009) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "import_histories", force: :cascade do |t|
    t.datetime "imported_at", null: false
    t.string "filename", null: false
    t.string "status", null: false
    t.integer "records_processed", default: 0
    t.integer "records_imported", default: 0
    t.text "error_details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer "code", null: false
    t.string "status"
    t.datetime "imported_t"
    t.string "url"
    t.string "creator"
    t.integer "created_t"
    t.integer "last_modified_t"
    t.string "product_name"
    t.string "quantity"
    t.string "brands"
    t.text "categories"
    t.text "labels"
    t.string "cities"
    t.string "purchase_places"
    t.string "stores"
    t.text "ingredients_text"
    t.text "traces"
    t.string "serving_size"
    t.decimal "serving_quantity", precision: 10, scale: 2
    t.integer "nutriscore_score"
    t.string "nutriscore_grade"
    t.string "main_category"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_products_on_code", unique: true
  end

end
