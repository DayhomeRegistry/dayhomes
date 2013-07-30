class RemoveStripeFromUsers < ActiveRecord::Migration
  def up
  	remove_column :users,:stripe_customer_token
  	remove_column :users,:plan
  end

  def down
  	add_column :users, :stripe_customer_token, :string
    add_column :users, :plan, :string, :default => 'baby'
  end
end
