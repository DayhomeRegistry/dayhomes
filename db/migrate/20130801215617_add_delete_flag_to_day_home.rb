class AddDeleteFlagToDayHome < ActiveRecord::Migration
  def change
  	add_column :day_homes, :deleted, :boolean, :default=>false
  	add_column :day_homes, :deleted_on, :datetime
  end
end
