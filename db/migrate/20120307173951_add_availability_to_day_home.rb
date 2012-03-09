class AddAvailabilityToDayHome < ActiveRecord::Migration
  def change
    add_column :day_homes, :enrolled, :integer, :null => false, :default => 0
    add_column :day_homes, :max_enrollment, :integer, :null => false, :default => 10
  end
end
