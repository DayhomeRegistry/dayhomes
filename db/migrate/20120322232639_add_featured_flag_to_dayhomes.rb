class AddFeaturedFlagToDayhomes < ActiveRecord::Migration
  def change
    add_column :day_homes, :featured, :boolean, :default => false
  end
end
