class RemoveOrganizationUsers < ActiveRecord::Migration
  def up
  	drop_table :organization_users

  	add_column :day_homes, :organization_id, :integer
  end

end
