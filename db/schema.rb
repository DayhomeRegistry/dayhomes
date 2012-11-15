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

ActiveRecord::Schema.define(:version => 20121109031740) do

  create_table "agencies", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "availability_types", :force => true do |t|
    t.string   "kind"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "availability"
  end

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.integer  "position",   :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "certification_types", :force => true do |t|
    t.string   "kind"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "day_home_agencies", :force => true do |t|
    t.integer  "day_home_id"
    t.integer  "agency_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
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

  create_table "day_home_contacts", :force => true do |t|
    t.string   "day_home_email"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "subject"
    t.text     "message"
    t.integer  "day_home_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "child_name"
    t.date     "child_birth_date"
    t.date     "child_start_date"
    t.string   "home_address"
  end

  add_index "day_home_contacts", ["day_home_id"], :name => "index_day_home_contacts_on_day_home_id"

  create_table "day_home_photos", :force => true do |t|
    t.integer  "day_home_id"
    t.string   "photo"
    t.string   "caption"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "day_home_photos", ["day_home_id"], :name => "index_day_home_photos_on_day_home_id"

  create_table "day_home_signup_requests", :force => true do |t|
    t.string   "day_home_name"
    t.string   "day_home_slug"
    t.string   "day_home_city"
    t.string   "day_home_province"
    t.string   "day_home_street1"
    t.string   "day_home_street2"
    t.string   "day_home_postal_code"
    t.string   "day_home_phone_number"
    t.text     "day_home_blurb"
    t.string   "first_name"
    t.string   "contact_phone_number"
    t.string   "contact_email"
    t.string   "preferred_time_to_contact"
    t.text     "comments"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "day_home_highlight"
    t.string   "day_home_email"
    t.string   "last_name"
    t.string   "plan",                      :default => "baby"
  end

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
    t.string   "email"
    t.string   "slug"
    t.string   "phone_number"
    t.text     "blurb"
    t.boolean  "licensed",               :default => false, :null => false
    t.string   "highlight"
    t.boolean  "approved",               :default => true
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.boolean  "all_day"
    t.text     "description"
    t.integer  "day_home_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "events", ["day_home_id"], :name => "index_events_on_day_home_id"

  create_table "forums", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "topics_count", :default => 0
    t.integer  "posts_count",  :default => 0
    t.integer  "position",     :default => 0
    t.integer  "category_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "forums", ["category_id"], :name => "index_forums_on_category_id"

  create_table "posts", :force => true do |t|
    t.text     "body"
    t.integer  "forum_id"
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "posts", ["forum_id"], :name => "index_posts_on_forum_id"
  add_index "posts", ["topic_id"], :name => "index_posts_on_topic_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "privacy_policies", :force => true do |t|
    t.string   "version"
    t.date     "effective_date"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "reviews", :force => true do |t|
    t.text     "content"
    t.integer  "rating",      :default => 0
    t.integer  "day_home_id"
    t.integer  "user_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "reviews", ["day_home_id"], :name => "index_reviews_on_day_home_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.integer  "hits",        :default => 0
    t.boolean  "sticky",      :default => false
    t.boolean  "locked",      :default => false
    t.integer  "posts_count"
    t.integer  "forum_id"
    t.integer  "user_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "topics", ["forum_id"], :name => "index_topics_on_forum_id"
  add_index "topics", ["user_id"], :name => "index_topics_on_user_id"

  create_table "user_agencies", :force => true do |t|
    t.integer  "user_id"
    t.integer  "agency_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_day_homes", :force => true do |t|
    t.integer  "day_home_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_day_homes", ["day_home_id", "user_id"], :name => "index_user_day_homes_on_day_home_id_and_user_id"
  add_index "user_day_homes", ["day_home_id"], :name => "index_user_day_homes_on_day_home_id"
  add_index "user_day_homes", ["user_id"], :name => "index_user_day_homes_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                                :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                            :default => false
    t.string   "crypted_password",                                     :null => false
    t.string   "password_salt",                                        :null => false
    t.string   "persistence_token",                                    :null => false
    t.string   "single_access_token",                                  :null => false
    t.string   "perishable_token",                                     :null => false
    t.integer  "login_count",                      :default => 0,      :null => false
    t.integer  "failed_login_count",               :default => 0,      :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.integer  "topics_count",                     :default => 0
    t.integer  "posts_count",                      :default => 0
    t.string   "facebook_access_token"
    t.string   "facebook_access_token_expires_in"
    t.date     "privacy_effective_date"
    t.string   "stripe_customer_token"
    t.string   "plan",                             :default => "baby"
  end

end
