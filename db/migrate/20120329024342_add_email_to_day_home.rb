class AddEmailToDayHome < ActiveRecord::Migration
  def change
    add_column :day_homes, :email, :string

  end
end
