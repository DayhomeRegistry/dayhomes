class RemoveAddressFromDayHomes < ActiveRecord::Migration
  def up
    remove_column :day_homes, :address
  end

  def down
    add_column :day_homes, :address, :string
  end
end
