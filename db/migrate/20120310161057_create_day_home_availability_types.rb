class CreateDayHomeAvailabilityTypes < ActiveRecord::Migration
  def change
    create_table :day_home_availability_types do |t|
      t.integer :day_home_id
      t.integer :availability_type_id

      t.timestamps
    end
  end
end
