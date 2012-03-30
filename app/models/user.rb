class User < ActiveRecord::Base
  acts_as_authentic
  validates_presence_of :first_name, :last_name

  has_many :reviews

  def full_name
    "#{first_name} #{last_name}"
  end
  
  def deliver_password_reset_instructions!
    UserMailer.password_reset_instructions(self).deliver
  end
  
end