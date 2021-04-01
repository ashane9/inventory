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

ActiveRecord::Schema.define(version: 2021_03_26_225945) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.integer "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "authentications", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "authentications_autographs", id: false, force: :cascade do |t|
    t.integer "autograph_id", null: false
    t.integer "authentication_id", null: false
    t.string "authentication_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "autographs", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "item_id", null: false
    t.bigint "purchase_id"
    t.bigint "value_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_autographs_on_item_id"
    t.index ["purchase_id"], name: "index_autographs_on_purchase_id"
    t.index ["value_id"], name: "index_autographs_on_value_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "image_file_path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "item_types", force: :cascade do |t|
    t.string "type_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "item_name", null: false
    t.text "description"
    t.bigint "item_type_id", null: false
    t.string "manufacturer"
    t.string "size"
    t.string "upc"
    t.bigint "purchase_id"
    t.bigint "value_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_type_id"], name: "index_items_on_item_type_id"
    t.index ["purchase_id"], name: "index_items_on_purchase_id"
    t.index ["value_id"], name: "index_items_on_value_id"
  end

  create_table "purchase_types", force: :cascade do |t|
    t.string "type_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.string "invoice_number"
    t.bigint "purchase_type_id", null: false
    t.string "location"
    t.date "date"
    t.decimal "sale_price", precision: 5, scale: 2
    t.decimal "buyer_premium", precision: 5, scale: 2
    t.decimal "shipping", precision: 5, scale: 2
    t.decimal "total_cost", precision: 6, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["purchase_type_id"], name: "index_purchases_on_purchase_type_id"
  end

  create_table "values", force: :cascade do |t|
    t.decimal "estimated_value", precision: 6, scale: 2
    t.date "as_of_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "autographs", "items"
  add_foreign_key "autographs", "purchases"
  add_foreign_key "autographs", "values"
  add_foreign_key "items", "item_types"
  add_foreign_key "items", "purchases"
  add_foreign_key "items", "values"
  add_foreign_key "purchases", "purchase_types"
end
