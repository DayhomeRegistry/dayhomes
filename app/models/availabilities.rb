class Availabilities < ActiveRecord::Base

  belongs_to :day_homes
  belongs_to :availability

end