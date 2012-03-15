class CreateDayHomeCertificationTypes < ActiveRecord::Migration
  def change
    create_table :day_home_certification_types do |t|
      t.integer :day_home_id
      t.integer :certification_type_id

      t.timestamps
    end
  end
end
