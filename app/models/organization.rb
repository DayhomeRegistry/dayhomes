class Organization < ActiveRecord::Base
  has_many :organization_users, :dependent => :destroy
  has_many :users, :through => :organization_users

  has_many :organization_locations, :dependent => :destroy
  has_many :locations, :through => :organization_locations
end