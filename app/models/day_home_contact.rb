class DayHomeContact < Object
  include ActiveModel::Validations
  include ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :day_home_email, :name, :subject, :message
  validates :name, :message, :subject, :day_home_email, :presence => true, :length => { :minimum => 3 }

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
