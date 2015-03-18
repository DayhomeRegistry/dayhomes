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

ActiveRecord::Schema.define(version: 20150206012003) do

  create_table "agencies", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "city",         limit: 255
    t.string   "province",     limit: 255
    t.string   "street1",      limit: 255
    t.string   "street2",      limit: 255
    t.string   "postal_code",  limit: 255
    t.string   "phone_number", limit: 255
  end

  create_table "availability_types", force: :cascade do |t|
    t.string   "kind",         limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "availability", limit: 255
  end

  create_table "categories", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "position",   limit: 4,   default: 0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "certification_types", force: :cascade do |t|
    t.string   "kind",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "communities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "day_home_agencies", force: :cascade do |t|
    t.integer  "day_home_id", limit: 4
    t.integer  "agency_id",   limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "day_home_availability_types", force: :cascade do |t|
    t.integer  "day_home_id",          limit: 4
    t.integer  "availability_type_id", limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "day_home_availability_types", ["availability_type_id"], name: "index_day_home_availability_types_on_availability_type_id", using: :btree
  add_index "day_home_availability_types", ["day_home_id"], name: "index_day_home_availability_types_on_day_home_id", using: :btree

  create_table "day_home_certification_types", force: :cascade do |t|
    t.integer  "day_home_id",           limit: 4
    t.integer  "certification_type_id", limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "day_home_certification_types", ["certification_type_id"], name: "index_day_home_certification_types_on_certification_type_id", using: :btree
  add_index "day_home_certification_types", ["day_home_id"], name: "index_day_home_certification_types_on_day_home_id", using: :btree

  create_table "day_home_contacts", force: :cascade do |t|
    t.string   "day_home_email",    limit: 255
    t.string   "name",              limit: 255
    t.string   "email",             limit: 255
    t.string   "phone",             limit: 255
    t.string   "subject",           limit: 255
    t.text     "message",           limit: 65535
    t.integer  "day_home_id",       limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "child_name",        limit: 255
    t.date     "child_birth_date"
    t.date     "child_start_date"
    t.string   "home_address",      limit: 255
    t.string   "child_name2",       limit: 255
    t.date     "child_birth_date2"
  end

  add_index "day_home_contacts", ["day_home_id"], name: "index_day_home_contacts_on_day_home_id", using: :btree

  create_table "day_home_photos", force: :cascade do |t|
    t.integer  "day_home_id",   limit: 4
    t.string   "photo",         limit: 255
    t.string   "caption",       limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "default_photo", limit: 1,   default: false
  end

  add_index "day_home_photos", ["day_home_id", "default_photo"], name: "index_day_home_photos_on_day_home_id_and_default_photo", using: :btree
  add_index "day_home_photos", ["day_home_id"], name: "index_day_home_photos_on_day_home_id", using: :btree

  create_table "day_home_signup_requests", force: :cascade do |t|
    t.string   "day_home_name",             limit: 255
    t.string   "day_home_slug",             limit: 255
    t.string   "day_home_city",             limit: 255
    t.string   "day_home_province",         limit: 255
    t.string   "day_home_street1",          limit: 255
    t.string   "day_home_street2",          limit: 255
    t.string   "day_home_postal_code",      limit: 255
    t.string   "day_home_phone_number",     limit: 255
    t.text     "day_home_blurb",            limit: 65535
    t.string   "first_name",                limit: 255
    t.string   "contact_phone_number",      limit: 255
    t.string   "contact_email",             limit: 255
    t.string   "preferred_time_to_contact", limit: 255
    t.text     "comments",                  limit: 65535
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.string   "day_home_highlight",        limit: 255
    t.string   "day_home_email",            limit: 255
    t.string   "last_name",                 limit: 255
    t.string   "plan",                      limit: 255,   default: "baby"
    t.string   "referral_email",            limit: 255
    t.string   "coupon",                    limit: 255
  end

  create_table "day_homes", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.float    "lat",                    limit: 24
    t.float    "lng",                    limit: 24
    t.boolean  "gmaps",                  limit: 1
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "city",                   limit: 255
    t.string   "province",               limit: 255
    t.string   "street1",                limit: 255
    t.string   "street2",                limit: 255
    t.string   "postal_code",            limit: 255
    t.boolean  "dietary_accommodations", limit: 1
    t.boolean  "featured",               limit: 1,     default: false
    t.string   "email",                  limit: 255
    t.string   "slug",                   limit: 255
    t.string   "phone_number",           limit: 255
    t.text     "blurb",                  limit: 65535
    t.boolean  "licensed",               limit: 1,     default: false, null: false
    t.string   "highlight",              limit: 255
    t.boolean  "approved",               limit: 1,     default: true
    t.integer  "location_id",            limit: 4
    t.string   "plan",                   limit: 255
    t.boolean  "deleted",                limit: 1,     default: false
    t.datetime "deleted_on"
  end

  add_index "day_homes", ["location_id"], name: "index_day_homes_on_location_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.boolean  "all_day",     limit: 1
    t.text     "description", limit: 65535
    t.integer  "day_home_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "events", ["day_home_id"], name: "index_events_on_day_home_id", using: :btree

  create_table "features", force: :cascade do |t|
    t.date     "start"
    t.date     "end"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "day_home_id",     limit: 4
    t.integer  "organization_id", limit: 4,                 null: false
    t.boolean  "freebee",         limit: 1, default: false
  end

  add_index "features", ["day_home_id", "end"], name: "index_features_on_day_home_id_and_end", using: :btree
  add_index "features", ["day_home_id"], name: "index_features_on_day_home_id", using: :btree

  create_table "forums", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "description",  limit: 65535
    t.integer  "topics_count", limit: 4,     default: 0
    t.integer  "posts_count",  limit: 4,     default: 0
    t.integer  "position",     limit: 4,     default: 0
    t.integer  "category_id",  limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "forums", ["category_id"], name: "index_forums_on_category_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "organization_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "community_id",    limit: 4
    t.string   "phone_number",    limit: 255
  end

  add_index "locations", ["organization_id"], name: "index_locations_on_organization_id", using: :btree

  create_table "organization_photos", force: :cascade do |t|
    t.integer  "logo_id",    limit: 4
    t.integer  "pin_id",     limit: 4
    t.string   "photo",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organization_photos", ["logo_id"], name: "index_organization_photos_on_logo_id", using: :btree
  add_index "organization_photos", ["pin_id"], name: "index_organization_photos_on_pin_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.string   "city",                  limit: 255
    t.string   "province",              limit: 255
    t.string   "street1",               limit: 255
    t.string   "street2",               limit: 255
    t.string   "postal_code",           limit: 255
    t.string   "billing_email",         limit: 255
    t.string   "phone_number",          limit: 255
    t.string   "stripe_customer_token", limit: 255
    t.string   "plan",                  limit: 255, default: "baby"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.integer  "affiliate_id",          limit: 4
    t.string   "affiliate_tag",         limit: 255
    t.string   "blurb",                 limit: 255
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "plan",                limit: 255
    t.integer  "day_homes",           limit: 4
    t.integer  "staff",               limit: 4
    t.integer  "locales",             limit: 4
    t.decimal  "price",                           precision: 10
    t.integer  "block_staff_addon",   limit: 4
    t.integer  "block_locales_addon", limit: 4
    t.datetime "active"
    t.datetime "inactive"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.integer  "free_features",       limit: 4,                  default: 0
    t.string   "subscription",        limit: 255,                default: "mth"
    t.integer  "events",              limit: 4,                  default: 0
  end

  create_table "posts", force: :cascade do |t|
    t.text     "body",       limit: 65535
    t.integer  "forum_id",   limit: 4
    t.integer  "topic_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "posts", ["forum_id"], name: "index_posts_on_forum_id", using: :btree
  add_index "posts", ["topic_id"], name: "index_posts_on_topic_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "privacy_policies", force: :cascade do |t|
    t.string   "version",        limit: 255
    t.date     "effective_date"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "content",     limit: 65535
    t.integer  "rating",      limit: 4,     default: 0
    t.integer  "day_home_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "reviews", ["day_home_id"], name: "index_reviews_on_day_home_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.integer  "hits",        limit: 4,   default: 0
    t.boolean  "sticky",      limit: 1,   default: false
    t.boolean  "locked",      limit: 1,   default: false
    t.integer  "posts_count", limit: 4
    t.integer  "forum_id",    limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "topics", ["forum_id"], name: "index_topics_on_forum_id", using: :btree
  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "upgrades", force: :cascade do |t|
    t.datetime "effective_date",            default: '2013-03-13 18:51:31'
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.integer  "old_plan_id",     limit: 4
    t.integer  "new_plan_id",     limit: 4
    t.integer  "organization_id", limit: 4,                                 null: false
  end

  create_table "user_agencies", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "agency_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "user_day_homes", force: :cascade do |t|
    t.integer  "day_home_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "user_day_homes", ["day_home_id", "user_id"], name: "index_user_day_homes_on_day_home_id_and_user_id", using: :btree
  add_index "user_day_homes", ["day_home_id"], name: "index_user_day_homes_on_day_home_id", using: :btree
  add_index "user_day_homes", ["user_id"], name: "index_user_day_homes_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,                 null: false
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.boolean  "admin",                  limit: 1,   default: false
    t.string   "encrypted_password",     limit: 255,                 null: false
    t.string   "password_salt",          limit: 255
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.integer  "failed_attempts",        limit: 4,   default: 0,     null: false
    t.datetime "last_request_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.integer  "topics_count",           limit: 4,   default: 0
    t.integer  "posts_count",            limit: 4,   default: 0
    t.string   "uid",                    limit: 255
    t.date     "privacy_effective_date"
    t.integer  "organization_id",        limit: 4
    t.integer  "location_id",            limit: 4
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "remember_token",         limit: 255
    t.datetime "remember_created_at"
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.string   "provider",               limit: 255
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "users_backup", force: :cascade do |t|
    t.string   "email",                            limit: 255,                 null: false
    t.string   "first_name",                       limit: 255
    t.string   "last_name",                        limit: 255
    t.boolean  "admin",                            limit: 1,   default: false
    t.string   "crypted_password",                 limit: 255,                 null: false
    t.string   "password_salt",                    limit: 255,                 null: false
    t.string   "persistence_token",                limit: 255,                 null: false
    t.string   "single_access_token",              limit: 255,                 null: false
    t.string   "perishable_token",                 limit: 255,                 null: false
    t.integer  "login_count",                      limit: 4,   default: 0,     null: false
    t.integer  "failed_login_count",               limit: 4,   default: 0,     null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip",                 limit: 255
    t.string   "last_login_ip",                    limit: 255
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.integer  "topics_count",                     limit: 4,   default: 0
    t.integer  "posts_count",                      limit: 4,   default: 0
    t.string   "facebook_access_token",            limit: 255
    t.string   "facebook_access_token_expires_in", limit: 255
    t.date     "privacy_effective_date"
    t.integer  "organization_id",                  limit: 4
    t.integer  "location_id",                      limit: 4
  end

  add_index "users_backup", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
