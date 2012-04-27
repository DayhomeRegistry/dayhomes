class PagesController < ApplicationController
  def index
    @featured_day_homes = DayHome.featured.reject{|day_home| day_home.photos.blank? }
  end
  
  def about
    
  end
end