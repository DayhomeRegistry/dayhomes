class AddDayHomeIdToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :day_home_id, :integer
    add_column :features, :organization_id, :integer, :null=>false
  end
end
