class AddFreeFeaturesToPlan < ActiveRecord::Migration
  def change
  	add_column :plans, :free_features, :integer, :default=>0
  	add_column :features, :freebee, :boolean, :default=>false

    # create plans
    baby = Plan.create!({:name=>"Baby Bear",:plan=>"baby",:day_homes=>1, :staff=>0,:locales=>1,:price=>0.00,:block_staff_addon=>1,:block_locales_addon=>1, :active=>Time.now})
    mama= Plan.create!({:name=>"Mama Bear",:plan=>"mama",:day_homes=>50, :staff=>1,:locales=>1,:price=>50.00,:block_staff_addon=>0,:block_locales_addon=>1, :active=>Time.now, :free_features => 1})
    papa=Plan.create!({:name=>"Papa Bear",:plan=>"papa",:day_homes=>250, :staff=>2,:locales=>5,:price=>250.00,:block_staff_addon=>0,:block_locales_addon=>0, :active=>Time.now, :free_features => 5})
    goldilocks=Plan.create!({:name=>"Goldilocks",:plan=>"goldilocks",:day_homes=>-1, :staff=>3,:locales=>-1,:price=>400.00,:block_staff_addon=>0,:block_locales_addon=>0, :active=>Time.now, :free_features => 8})

  end
end
