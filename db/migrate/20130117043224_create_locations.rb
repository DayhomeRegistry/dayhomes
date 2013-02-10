class CreateLocations < ActiveRecord::Migration
  def up
    create_table :locations do |t|
      t.string :name
      t.integer :organization_id
      #t.foreign_key :organizations

      t.timestamps
    end

    add_column :day_homes,:location_id,:integer
    
	  
  end

  def down
    drop_table :locations
    remove_column :day_homes,:location_id
  end

end
