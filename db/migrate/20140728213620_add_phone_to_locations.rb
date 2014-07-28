class AddPhoneToLocations < ActiveRecord::Migration
  def change
  	add_column :locations, :phone_number, :string
  end
end
