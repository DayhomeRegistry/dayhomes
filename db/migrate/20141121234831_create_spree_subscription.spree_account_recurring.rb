# This migration comes from spree_account_recurring (originally 20131119054322)
class CreateSpreeSubscription < ActiveRecord::Migration
  def change
    create_table :spree_subscriptions do |t|
      t.integer :plan_id
      t.string :email
      t.integer :user_id
      t.string :card_customer_token
      t.datetime :subscribed_at
      t.datetime :unsubscribed_at
    end

    add_index :spree_subscriptions, :subscribed_at
    add_index :spree_subscriptions, :unsubscribed_at
    add_index :spree_subscriptions, :plan_id
  end
end
