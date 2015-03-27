class MigrateToOmniAuth < ActiveRecord::Migration
  def up
  	rename_column :users, :facebook_access_token, :uid
  	remove_column :users, :facebook_access_token_expires_in
  	add_column :users, :provider, :string
  end

  def down
  	rename_column :users, :uid, :facebook_access_token
  	remove_column :users, :provider
  	add_column :users, :facebook_access_token_expires_in, :string
  end
end
