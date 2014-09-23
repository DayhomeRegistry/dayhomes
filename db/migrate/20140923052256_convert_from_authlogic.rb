class ConversionUser < ActiveRecord::Base
    set_table_name "users_backup"
end
class ConvertFromAuthlogic < ActiveRecord::Migration
  def up
  	rename_column :users, :crypted_password, :encrypted_password

	add_column :users, :confirmation_token, :string, :limit => 255
	add_column :users, :confirmed_at, :timestamp
	add_column :users, :confirmation_sent_at, :timestamp
	execute "UPDATE users SET confirmed_at = created_at, confirmation_sent_at = created_at"
	add_column :users, :reset_password_token, :string, :limit => 255

	add_column :users, :remember_token, :string, :limit => 255
	add_column :users, :remember_created_at, :timestamp
	rename_column :users, :login_count, :sign_in_count
	rename_column :users, :current_login_at, :current_sign_in_at
	rename_column :users, :last_login_at, :last_sign_in_at
	rename_column :users, :current_login_ip, :current_sign_in_ip
	rename_column :users, :last_login_ip, :last_sign_in_ip

	rename_column :users, :failed_login_count, :failed_attempts
	add_column :users, :unlock_token, :string, :limit => 255
	add_column :users, :locked_at, :timestamp

	remove_column :users, :persistence_token
	remove_column :users, :perishable_token
	remove_column :users, :single_access_token

	add_index :users, :confirmation_token,   :unique => true
	add_index :users, :reset_password_token, :unique => true
	add_index :users, :unlock_token,         :unique => true
  end

  def down
  	drop_table :users
  	create_table "users", :force => true do |t|
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

	ConversionUser.all.each do |user|
		newUser = User.new()
		newUser.email=user.email
	    newUser.first_name=user.first_name
	    newUser.last_name=user.last_name
	    newUser.admin=user.admin
	    newUser.crypted_password=user.crypted_password
	    newUser.password_salt=user.password_salt
	    newUser.persistence_token=user.persistence_token
	    newUser.single_access_token=user.single_access_token
	    newUser.perishable_token=user.perishable_token
	    newUser.login_count=user.login_count
	    newUser.failed_login_count=user.failed_login_count
	    newUser.last_request_at=user.last_request_at
	    newUser.current_login_at=user.current_login_at
	    newUser.last_login_at=user.last_login_at
	    newUser.current_login_ip=user.current_login_ip
	    newUser.last_login_ip=user.last_login_ip
	    newUser.created_at=user.created_at
	    newUser.updated_at=user.updated_at
	    newUser.topics_count=user.topics_count
	    newUser.posts_count=user.posts_count
	    newUser.facebook_access_token=user.facebook_access_token
	    newUser.facebook_access_token_expires_in=user.facebook_access_token_expires_in
	    newUser.privacy_effective_date=user.privacy_effective_date
	    newUser.organization_id=user.organization_id
	    newUser.location_id=user.location_id
		newUser.save
	end
  end
end
