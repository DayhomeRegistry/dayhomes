class AddDayHomeEmailToDayHomeSignupRequest < ActiveRecord::Migration
  def change
    add_column :day_home_signup_requests, :day_home_email, :string

  end
end
