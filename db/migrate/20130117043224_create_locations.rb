class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name

      t.timestamps
    end
    create_table :organization_locations do |t|
      t.column :organization_id, :integer
	  t.column :location_id, :integer

      t.timestamps
    end
    create_table :location_day_homes do |t|
	  t.column :location_id, :integer
	  t.column :day_home_id, :integer

      t.timestamps
    end
    
  end
end
