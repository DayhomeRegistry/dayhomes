class RemovePlanFromDayHomes < ActiveRecord::Migration
  def change
    remove_column :day_homes, :plan
  end
end
