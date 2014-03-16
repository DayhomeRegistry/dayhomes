class AddAffiliateIdToOrganization < ActiveRecord::Migration
  def up
  	add_column :organizations, :affiliate_id, :integer
  	add_column :organizations, :affiliate_tag, :string

  	Organization.all.each do |org|
  		a = [('0'..'9')].map { |i| i.to_a }.flatten
  		b = [('A'..'Z')].map { |i| i.to_a }.flatten
		string = (0...3).map { b[rand(b.length)] }.join
		string += (0...2).map { a[rand(a.length)] }.join
		string += (0...3).map { b[rand(b.length)] }.join
		org.update_attribute(:affiliate_tag, string)
    end
  end
  def down
  	remove_column :organizations, :affiliate_id
  	remove_column :organizations, :affiliate_tag
  end
end
