class Agency < ActiveRecord::Base

  has_many :user_agencies, :dependent => :destroy
  has_many :users, :through => :user_agencies

end
