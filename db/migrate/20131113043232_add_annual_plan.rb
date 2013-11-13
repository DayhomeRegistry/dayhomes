class AddAnnualPlan < ActiveRecord::Migration
  def up
  	plan=Plan.find_by_name("Baby Bear")
  	plan.plan="babyannual"
  	plan.price=21
  	plan.save
  end

  def down
  	plan=Plan.find_by_name("Baby Bear")
  	plan.plan="baby"
  	plan.price=0
  	plan.save
  end
end
