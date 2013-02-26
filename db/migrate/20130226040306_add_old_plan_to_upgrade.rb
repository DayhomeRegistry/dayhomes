class AddOldPlanToUpgrade < ActiveRecord::Migration
  def change
  	remove_column :upgrades, :plan_id
  	add_column :upgrades, :old_plan_id, :integer
  	add_column :upgrades, :new_plan_id, :integer
  end
end
