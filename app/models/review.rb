class Review < ActiveRecord::Base
  validates_presence_of :day_home_id, :user_id, :content
  validates_uniqueness_of :user_id, :scope =>  :day_home_id, :message => 'review already exists for this dayhome!'

  belongs_to :user
  belongs_to :day_home

  validates :content, :length => { :minimum => 5, :maximum => 1000 }
  validates :rating, :length => { :in => 0..5 }

end
