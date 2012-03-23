class DayHomePhoto < ActiveRecord::Base
  mount_uploader :photo, DayHomePhotoUploader
  
  belongs_to :day_home
  validates :photo, :presence => true
  
end