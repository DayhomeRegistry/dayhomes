# This migration comes from spree_account_recurring (originally 20140812035502)
class AddPreferences < ActiveRecord::Migration
  def change
    add_column :spree_recurrings, :preferences, :text
  end
end
