class AddIndexToTypes < ActiveRecord::Migration
  def change
    add_index :day_home_certification_types, :day_home_id
    add_index :day_home_certification_types, :certification_type_id
    add_index :day_home_availability_types, :day_home_id
    add_index :day_home_availability_types, :availability_type_id
  end
end
