class UserDayHome < ActiveRecord::Base
  belongs_to :user
  belongs_to :day_home
  
  validates_uniqueness_of :user_id, :scope => :day_home_id
end