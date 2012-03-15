class DayHomeCertificationType < ActiveRecord::Base
  belongs_to :dayhome
  belongs_to :certification_type

end
