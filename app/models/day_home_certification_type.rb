class DayHomeCertificationType < ActiveRecord::Base
  validates_presence_of :day_home_id, :certification_type_id

  belongs_to :dayhome
  belongs_to :certification_type

end
