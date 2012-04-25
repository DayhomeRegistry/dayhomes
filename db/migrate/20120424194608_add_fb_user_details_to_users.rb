class AddFbUserDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_access_token, :string
    add_column :users, :facebook_access_token_expires_in, :string
  end
end
