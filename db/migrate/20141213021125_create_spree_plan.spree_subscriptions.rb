# This migration comes from spree_subscriptions (originally 20141206103101)
class CreateSpreePlan < ActiveRecord::Migration
  def self.up
    create_table :spree_plans do |t|
      t.integer :variant_id
      t.integer :payment_method_id
      t.string  :name
      t.string  :api_plan_id
      # t.decimal :amount
      # t.string :interval
      # t.integer :interval_count, :default => 1
      # t.string :currency
      # t.integer :trial_period_days, :default => 0
      # t.boolean :active, :default => false
      t.datetime :deleted_at
    end

    add_index :spree_plans, [:variant_id, :payment_method_id]
  end
  def self.down
    drop_table :spree_plans 
  end
end
