class AddPlanToDayHome < ActiveRecord::Migration
  def change
    add_column :day_homes, :plan, :string, :default => 'baby'

  end
end
