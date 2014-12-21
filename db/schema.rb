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

ActiveRecord::Schema.define(version: 20141219204951) do

  create_table "brands", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_items_count", default: 0, null: false
  end

  create_table "buycycle_lifecycles", force: true do |t|
    t.integer  "buycycle_stage_id"
    t.integer  "lifecycle_stage_id"
    t.integer  "customer_count",     default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buycycle_stages", force: true do |t|
    t.string   "name"
    t.integer  "customer_count", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_purchases"
    t.float    "revenue"
    t.float    "aov"
    t.float    "ltv"
    t.integer  "lifecycle_stage_id"
    t.integer  "buycycle_stage_id"
    t.integer  "buycycle_lifecycle_id"
  end

  create_table "lifecycle_stages", force: true do |t|
    t.string   "name"
    t.integer  "customer_count", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "conv_time"
    t.float    "conv_rate"
  end

  create_table "order_items", force: true do |t|
    t.integer  "customer_id"
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "product_variation_id"
    t.integer  "product_category_id"
    t.integer  "brand_id"
    t.float    "item_discount"
    t.float    "item_price"
    t.integer  "item_quantity"
    t.float    "item_subtotal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "customer_id"
    t.boolean  "mobile"
    t.string   "channel"
    t.float    "order_total"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lifecycle_stage_id"
    t.string   "device_type"
  end

  create_table "product_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "order_items_count", default: 0, null: false
  end

  create_table "product_variations", force: true do |t|
    t.integer  "product_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_items_count", default: 0, null: false
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.integer  "product_category_id"
    t.integer  "brand_id"
    t.float    "price"
    t.float    "sale_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_items_count",   default: 0, null: false
    t.integer  "customer_count",      default: 0, null: false
  end

end
