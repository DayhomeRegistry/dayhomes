class OrganizationLocation < ActiveRecord::Base
  belongs_to :organization
  belongs_to :location

  validates_uniqueness_of :location_id, :scope => :organization_id
end