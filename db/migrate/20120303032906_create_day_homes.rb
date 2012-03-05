class CreateDayHomes < ActiveRecord::Migration
  def change
    create_table :day_homes do |t|
      t.string :name
      t.float :lat
      t.float :lng
      t.string :address
      t.boolean :gmaps

      t.timestamps
    end
  end
end
