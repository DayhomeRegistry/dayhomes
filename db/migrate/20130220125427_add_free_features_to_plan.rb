class AddFreeFeaturesToPlan < ActiveRecord::Migration
  def change
  	add_column :plans, :free_features, :integer, :default=>0
  end
end
