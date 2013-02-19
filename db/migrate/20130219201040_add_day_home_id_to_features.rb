class AddDayHomeIdToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :day_home_id, :integer
  end
end
