class AddLicensedToDayHome < ActiveRecord::Migration
  def change
    add_column :day_homes, :licensed, :boolean, :null => false, :default => 0
  end
end
