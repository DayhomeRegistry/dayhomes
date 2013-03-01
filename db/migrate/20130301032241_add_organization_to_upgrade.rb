class AddOrganizationToUpgrade < ActiveRecord::Migration
  def change
  	add_column :upgrades, :organization_id, :integer, :null=>false
  end
end
