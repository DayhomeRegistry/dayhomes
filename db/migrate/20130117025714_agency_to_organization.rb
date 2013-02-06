class AgencyToOrganization < ActiveRecord::Migration
  def change
  	create_table :organizations do |t|
	    t.string   "name"
	    t.string   "city"
	    t.string   "province"
	    t.string   "street1"
	    t.string   "street2"
	    t.string   "postal_code"
	    t.string   "billing_email"
	    t.string   "phone_number"
	    t.string   :stripe_customer_token
    	t.string   :plan,  :default => 'baby'

	    t.timestamps
	end
	create_table :organization_users do |t|
      t.column :user_id, :integer
      t.column :organization_id, :integer
 
      t.timestamps
    end
	
  end
end
