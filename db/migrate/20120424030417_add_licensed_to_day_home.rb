class AddLicensedToDayHome < ActiveRecord::Migration
  def change
    add_column :day_homes, :licensed, :boolean
  end
end
