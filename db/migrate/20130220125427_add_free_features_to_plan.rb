class AddFreeFeaturesToPlan < ActiveRecord::Migration
  def change
  	add_column :plans, :free_features, :integer, :default=>0
  	add_column :features, :freebee, :boolean, :default=>false
  end
end
