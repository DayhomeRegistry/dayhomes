class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :organization_id
      t.foreign_key :organizations

      t.timestamps
    end

    change_table :day_homes do |t|
      t.integer :location_id
      t.foreign_key :locations, dependent: :delete
    end
    
	  
  end
end
