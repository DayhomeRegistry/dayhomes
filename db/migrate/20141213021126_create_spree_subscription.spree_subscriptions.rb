# This migration comes from spree_subscriptions (originally 20141206103102)
class CreateSpreeSubscription < ActiveRecord::Migration
  def change
    create_table :spree_subscriptions do |t|
      t.integer :plan_id
      t.integer :user_id
      t.string :api_sub_id
      t.datetime :subscribed_at
      t.datetime :unsubscribed_at
    end

    add_index :spree_subscriptions, :subscribed_at
    add_index :spree_subscriptions, :unsubscribed_at
    add_index :spree_subscriptions, :plan_id
  end
end
