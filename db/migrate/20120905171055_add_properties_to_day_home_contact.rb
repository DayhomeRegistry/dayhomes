class AddPropertiesToDayHomeContact < ActiveRecord::Migration
  def change
    add_column :day_home_contacts, :child_name, :string

    add_column :day_home_contacts, :child_birth_date, :date

    add_column :day_home_contacts, :child_start_date, :date

    add_column :day_home_contacts, :home_address, :string

  end
end
