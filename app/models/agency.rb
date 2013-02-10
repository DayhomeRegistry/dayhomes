class Agency < ActiveRecord::Base

  has_many :user_agencies, :dependent => :destroy
  has_many :users, :through => :user_agencies
  
  has_many :day_home_agencies, :dependent => :destroy
  has_many :day_homes, :through => :day_home_agencies

  validates :name, :presence => true

  def add_user_by_id(id)
    user = User.find_by_id(id)
    return self.add_user(user)
  end
  def add_user(user)
    if user.day_homes.count > 0 then
      errors.add(:users,"cannot have a dayhome and an agency. (UserID: "+user.id.to_s+")")
      return false
    end
    self.users<<(user)
  end
  def add_day_home(day_home)
    self.day_homes<<(day_home)
  end
  
  def assign_user_ids=(user_id_attrs=[])
    self.users = []
    User.find_all_by_id(user_id_attrs).each do |user|
      if user.day_homes.count>0 then
        raise user.day_homes.count.to_s
        errors.add(:users,"cannot have a dayhome and an agency. (UserID: "+user.id.to_s+")")
        return false
      else
        self.users << user
      end
    end
  end
  
  def assign_day_home_ids=(day_home_id_attrs=[])
    self.day_homes = []
    self.day_homes = DayHome.find_all_by_id(day_home_id_attrs)
  end
  def address
    lstreet = "#{street1}#{street2}".blank? ? "" : "#{street1}#{street2},"
    lcity = "#{city}".blank? ? "" : " #{city},"
  
    lstreet+lcity+ ("#{province}".blank? ? "":" #{province},") + " #{postal_code}"
  end
end