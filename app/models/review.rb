class Review < ActiveRecord::Base
  validates_presence_of :day_home_id, :user_id

  belongs_to :user
  belongs_to :day_home

  validates :content, :length => { :minimum => 5, :maximum => 1000 }
  validates :rating, :length => { :in => 1..5 }

end
