class AddPreferencesColumnToSpreeProducts < ActiveRecord::Migration
  def up
    add_column :spree_products, :preferences, :text
  end

  def down
    remove_column :spree_products, :preferences
  end
end