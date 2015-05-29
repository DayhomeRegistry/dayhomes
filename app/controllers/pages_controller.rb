class PagesController < ApplicationController
  layout 'application'

  
  def index 
    edmonton = Community.where("name like 'Edmonton%'");
    calgary =  Community.where("name like 'Calgary%'");
    fortMac =  Community.where("name like 'Fort McMurray%'");
    @edmonton=DayHome.joins(:location).where(locations: {community_id: edmonton}).count
    @calgary=DayHome.joins(:location).where(locations: {community_id: calgary}).count
    @fortMac=DayHome.joins(:location).where(locations: {community_id: fortMac}).count
    @featured_day_homes = DayHome.featured.reject{|day_home| !day_home.approved? }    
    if (@featured_day_homes.count ==0)
      @featured_day_homes = DayHome.all.limit(3).offset(rand(DayHome.all.count-3))  
    end
    
    render layout: "landingpage"
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
  def partners
    render layout: "mobilefriendly"
  end
  
end

# +--------------------+
# | name               |
# +--------------------+
# | Edmonton           |
# | Sherwood Park      |
# | Fort Saskatchewan  |
# | Tofield            |
# | Ardrossan          |
# | Stony Plain        |
# | Beaumont           |
# |                    |
# | Spruce Grove       |
# | Leduc              |
# | Calgary            |
# | Twin Brooks        |
# | Millwoods          |
# | blackfalds         |
# | Lancaster Park     |
# | Airdrie            |
# | St Albert          |
# +--------------------+