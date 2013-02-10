class RemoveOrganizationUsers < ActiveRecord::Migration
  def up
  	drop_table :organization_users

  	add_column :users, :organization_id, :integer
  end
  def down
  	remove_column :users,:organization_id
  end

end
