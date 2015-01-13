class AddDefaultToPlan < ActiveRecord::Migration
  def change
  	add_column :plans, :org_type_default, :bool, default: false
  	add_column :plans, :org_type, :string
  	add_column :plans, :product_id, :integer

  	add_column :plans, :monthly_price, :decimal, default:0
  	add_column :plans, :annual_price, :decimal, default: 0

  	Plan.where(subscription:'mth').each do |sub|
  		sub.monthly_price = sub.price
  		sub.org_type = 'group'
  		sub.save
  	end
  	Plan.where(subscription: 'yr').each do |sub|
  		sub.annual_price = sub.price
  		sub.org_type = 'individual'
  		sub.org_type_default = true
  		sub.save
  	end

  	# remove_column :plans, :subscription
  	# remove_column :plans, :price
  end
end
