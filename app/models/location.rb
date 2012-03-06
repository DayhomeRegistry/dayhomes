class Location < ActiveRecord::Base
  belongs_to :locationable, :polymorphic => true

  validates :city, :presence => true
  validates :state, :presence => {:if => :in_us?}
  validates :country, :presence => true

  def in_us?
    country == 'US'
  end

end