class AddIndexToReview < ActiveRecord::Migration
  def change
    add_index :reviews, :day_home_id
    add_index :reviews, :user_id
  end
end
