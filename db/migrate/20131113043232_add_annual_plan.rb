class AddAnnualPlan < ActiveRecord::Migration
  def up
  	plan=Plan.find_by_plan("baby")
  	plan.inactive=DateTime.now()
    plan.name="Baby Bear Free"
    plan.free_features=0
  	plan.save

    plan = Plan.new()
    plan.plan="babyannual"
    plan.price="21"
    plan.name="Baby Bear"
    plan.day_homes=1
    plan.staff=0
    plan.locales=1
    plan.block_staff_addon=1
    plan.block_locales_addon=1
    plan.free_features=1
    plan.active = DateTime.now()
    plan.save
  end

  def down
  	plan=Plan.find_by_plan("babyannual")
  	plan.destroy

    plan=Plan.find_by_plan("baby")
    plan.name="Baby Bear"
    plan.save
  end
end
