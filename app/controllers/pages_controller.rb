class PagesController < ApplicationController
  def index
    @featured_day_homes = DayHome.featured.reject{|day_home| day_home.photos.blank?||!day_home.approved? }
  end
  
  def about
  end
  
  def privacy
  end
  
  def acknowledge
    current_user.privacy_effective_date = Time.now()
    current_user.save
    redirect_to request.referer
  end
end