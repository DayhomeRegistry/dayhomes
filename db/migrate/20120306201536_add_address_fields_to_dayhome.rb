class AddAddressFieldsToDayhome < ActiveRecord::Migration
  def change
    add_column :day_homes, :city, :string
    add_column :day_homes, :province, :string
    add_column :day_homes, :street1, :string
    add_column :day_homes, :street2, :string
    add_column :day_homes, :postal_code, :string
  end
end
