class Agency < ActiveRecord::Base

  has_many :user_agencies, :dependent => :destroy
  has_many :users, :through => :user_agencies
  
  has_many :day_home_agencies, :dependent => :destroy
  has_many :day_homes, :through => :day_home_agencies

  validates :name, :email, :presence => true

  def add_user(user)
    if user.day_homes.count > 0 then
      errors.add(:users,"A user cannot have a dayhome and an agency")
      return false
    end
    self.users<<(user)
  end
  def add_day_home(day_home)
    self.day_homes<<(day_home)
  end
  
  def assign_user_ids=(user_id_attrs=[])
    self.users = []
    self.users = User.find_all_by_id(user_id_attrs)
  end
  def assign_day_home_ids=(day_home_id_attrs=[])
    self.day_homes = []
    self.day_homes = DayHome.find_all_by_id(day_home_id_attrs)
  end
end
