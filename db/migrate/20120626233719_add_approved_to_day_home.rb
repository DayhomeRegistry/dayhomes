class AddApprovedToDayHome < ActiveRecord::Migration
  def change
	add_column :day_homes, :approved, :boolean, :default=>true
  end
end
