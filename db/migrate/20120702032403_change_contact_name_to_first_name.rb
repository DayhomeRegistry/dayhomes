class ChangeContactNameToFirstName < ActiveRecord::Migration
  def change
    rename_column :day_home_signup_requests, :contact_name, :first_name
  end

end
