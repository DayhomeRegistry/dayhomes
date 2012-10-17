class UserAgency < ActiveRecord::Base
  belongs_to :user
  belongs_to :agency

  validates_uniqueness_of :user_id, :scope => :agency_id

end
