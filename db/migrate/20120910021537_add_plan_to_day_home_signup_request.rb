class AddPlanToDayHomeSignupRequest < ActiveRecord::Migration
  def change
    add_column :day_home_signup_requests, :plan, :string,:default => "baby"

  end
end
