
class BackupUsers < ActiveRecord::Migration
	def up
		create_table "users_backup", :force => true do |t|
		    t.string   "email",                                               :null => false
		    t.string   "first_name"
		    t.string   "last_name"
		    t.boolean  "admin",                            :default => false
		    t.string   "crypted_password",                                    :null => false
		    t.string   "password_salt",                                       :null => false
		    t.string   "persistence_token",                                   :null => false
		    t.string   "single_access_token",                                 :null => false
		    t.string   "perishable_token",                                    :null => false
		    t.integer  "login_count",                      :default => 0,     :null => false
		    t.integer  "failed_login_count",               :default => 0,     :null => false
		    t.datetime "last_request_at"
		    t.datetime "current_login_at"
		    t.datetime "last_login_at"
		    t.string   "current_login_ip"
		    t.string   "last_login_ip"
		    t.datetime "created_at",                                          :null => false
		    t.datetime "updated_at",                                          :null => false
		    t.integer  "topics_count",                     :default => 0
		    t.integer  "posts_count",                      :default => 0
		    t.string   "facebook_access_token"
		    t.string   "facebook_access_token_expires_in"
		    t.date     "privacy_effective_date"
		    t.integer  "organization_id"
		    t.integer  "location_id"
		end

		add_index "users_backup", ["email"], :name => "index_users_on_email", :unique => true

	end
end