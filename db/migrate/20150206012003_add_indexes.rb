class AddIndexes < ActiveRecord::Migration
  def change
  	add_index :features, :day_home_id
  	add_index :features, [:day_home_id,:end]
  	add_index :day_home_photos, :day_home_id
  	add_index :day_home_photos, [:day_home_id,:default_photo]
  	add_index :organization_photos, :pin_id
  	add_index :organization_photos, :logo_id
  	add_index :day_homes, :location_id
  	add_index :locations, :organization_id
  end
end
