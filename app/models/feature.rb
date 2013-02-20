class Feature < ActiveRecord::Base
	belongs_to :organization
	belongs_to :day_home

end
