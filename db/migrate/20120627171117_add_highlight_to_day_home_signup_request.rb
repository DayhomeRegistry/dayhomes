class AddHighlightToDayHomeSignupRequest < ActiveRecord::Migration
  def change
    add_column :day_home_signup_requests, :day_home_highlight, :string
  end
end
