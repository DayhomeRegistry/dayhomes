class RemoveOrganizationUsers < ActiveRecord::Migration
  def up
  	add_column :users, :organization_id, :integer
 	
 	OrganizationUser.all.each do |row|
 		u = User.find_by_id(row.user_id)
 		u.organization = Organization.find_by_id(row.organization_id)
 		u.save
 	end

  	#drop_table :organization_users

  end
  def down
  	remove_column :users,:organization_id
  end

end
