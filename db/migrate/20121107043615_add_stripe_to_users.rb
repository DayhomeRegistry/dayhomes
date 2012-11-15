class AddStripeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_customer_token, :string
    add_column :users, :plan, :string, :default => 'baby'
  end
end
