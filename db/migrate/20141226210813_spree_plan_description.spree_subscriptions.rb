# This migration comes from spree_subscriptions (originally 2014122614301)
class SpreePlanDescription < ActiveRecord::Migration
  def self.up
    add_column :spree_plans, :description, :string 
  end
  def self.down
    remove_column :spree_plans, :description
  end
end
