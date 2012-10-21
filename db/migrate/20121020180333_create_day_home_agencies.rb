class CreateDayHomeAgencies < ActiveRecord::Migration
  def change
    create_table :day_home_agencies do |t|
      t.column :day_home_id, :integer
      t.column :agency_id, :integer

      t.timestamps
    end
  end
end
