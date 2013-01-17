class OrganizationUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  validates_uniqueness_of :organization_id, :scope => :user_id
end