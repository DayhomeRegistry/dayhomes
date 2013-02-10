class DayHomeAgency < ActiveRecord::Base
  belongs_to :day_home
  belongs_to :agency

  validates_uniqueness_of :day_home_id, :scope => :agency_id

end