class AddKarmaToDayHomeSignupRequest < ActiveRecord::Migration
  def change
  	add_column :day_home_signup_requests, :referral_email, :string
    add_column :day_home_signup_requests, :coupon, :string
  end
end
