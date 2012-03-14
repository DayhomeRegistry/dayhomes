class RemoveEnrolledFromDayHome < ActiveRecord::Migration
  def up
    remove_column :day_homes, :enrolled
    remove_column :day_homes, :max_enrollment
  end

  def down
    add_column :day_homes, :enrolled
    add_column :day_homes, :max_enrollment
  end
end
