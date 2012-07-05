class AddLastNameToDayHomeSignupRequest < ActiveRecord::Migration
  def change
    add_column :day_home_signup_requests, :last_name, :string

  end
end
