class AddEventsToPlan < ActiveRecord::Migration
  def up
  	add_column :plans, :subscription, :string, :default=>"mth"
  	add_column :plans, :events, :integer,:default=>0
  	plan=Plan.find_by_name("Baby Bear")
  	plan.subscription="yr"
  	plan.events=1
    plan.free_features=1
  	plan.save
  end
  def down
  	remove_column :plans,:subscription
  	remove_column :plans,:events
  end
end
