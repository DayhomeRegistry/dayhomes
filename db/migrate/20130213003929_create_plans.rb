class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.string :plan
      t.integer :day_homes
      t.integer :staff
      t.integer :locales
      t.decimal :price
      t.integer :block_staff_addon
      t.integer :block_locales_addon

      t.datetime :active 
      t.datetime :inactive

      t.timestamps
    end

  end
end
