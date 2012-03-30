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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120329184141) do

  create_table "availability_types", :force => true do |t|
    t.string   "kind"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "availability"
  end

  create_table "certification_types", :force => true do |t|
    t.string   "kind"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "day_home_availability_types", :force => true do |t|
    t.integer  "day_home_id"
    t.integer  "availability_type_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "day_home_availability_types", ["availability_type_id"], :name => "index_day_home_availability_types_on_availability_type_id"
  add_index "day_home_availability_types", ["day_home_id"], :name => "index_day_home_availability_types_on_day_home_id"

  create_table "day_home_certification_types", :force => true do |t|
    t.integer  "day_home_id"
    t.integer  "certification_type_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "day_home_certification_types", ["certification_type_id"], :name => "index_day_home_certification_types_on_certification_type_id"
  add_index "day_home_certification_types", ["day_home_id"], :name => "index_day_home_certification_types_on_day_home_id"

  create_table "day_home_photos", :force => true do |t|
    t.integer  "day_home_id"
    t.string   "photo"
    t.string   "caption"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "day_home_photos", ["day_home_id"], :name => "index_day_home_photos_on_day_home_id"

  create_table "day_homes", :force => true do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lng"
    t.boolean  "gmaps"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "city"
    t.string   "province"
    t.string   "street1"
    t.string   "street2"
    t.string   "postal_code"
    t.boolean  "dietary_accommodations"
    t.boolean  "featured",               :default => false
    t.string   "slug"
  end

  create_table "reviews", :force => true do |t|
    t.text     "content"
    t.integer  "rating"
    t.integer  "day_home_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "reviews", ["day_home_id"], :name => "index_reviews_on_day_home_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                  :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",               :default => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

end
