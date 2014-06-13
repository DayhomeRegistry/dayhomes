class AddSecondChildToDayHomeContact < ActiveRecord::Migration
  def change
  	add_column :day_home_contacts, :child_name2, :string
  	add_column :day_home_contacts, :child_birth_date2, :date
  end
end
