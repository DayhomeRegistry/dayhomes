class AddPublicPhoneNumberToDayHomes < ActiveRecord::Migration
  def change
    add_column :day_homes, :phone_number, :string
    add_column :day_homes, :blurb, :text
  end
end
