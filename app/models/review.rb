class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :day_home

end
