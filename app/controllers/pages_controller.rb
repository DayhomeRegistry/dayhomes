class PagesController < ApplicationController
  layout 'application'

  def index    
    @featured_day_homes = DayHome.featured.reject{|day_home| !day_home.approved? }    
    if (@featured_day_homes.count ==0)
      #@featured_day_homes = [DayHome.find(:first, :offset =>rand(DayHome.all.count))]
      @featured_day_homes = DayHome.all.reject{|day_home| day_home.photos.blank?||!day_home.approved? }    
    end
    
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