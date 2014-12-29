# This migration comes from spree_related_products (originally 20130727004612)
class AddPositionToSpreeRelations < ActiveRecord::Migration
	def change
    	add_column :spree_relations, :position, :integer
  	end
end
