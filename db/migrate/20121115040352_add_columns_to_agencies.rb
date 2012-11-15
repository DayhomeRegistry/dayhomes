class AddColumnsToAgencies < ActiveRecord::Migration
  def change
    remove_column :agencies, :email
    
    add_column :agencies, :city, :string
    add_column :agencies, :province, :string
    add_column :agencies, :street1, :string
    add_column :agencies, :street2, :string
    add_column :agencies, :postal_code, :string
    add_column :agencies, :phone_number, :string
  end
end
