class AddBlurbToOrganizations < ActiveRecord::Migration
  def change
  	add_column :organizations, :blurb, :string
  end
end
