class DayHomeCertificationType < ActiveRecord::Base
  validates_presence_of :day_home, :certification_type

  belongs_to :day_home
  belongs_to :certification_type

end
