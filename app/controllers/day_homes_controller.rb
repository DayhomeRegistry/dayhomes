class DayHomesController < ApplicationController
  def show
    @day_home = DayHome.find(params[:id])
    @styled_day_homes = style_dayhomes([@day_home])
  end
  
  private

  def style_dayhomes(day_homes)
    day_homes.to_gmaps4rails do |dayhome, marker|
      marker.infowindow render_to_string(:partial => "/searches/pin", :locals => { :dayhome => dayhome})
      marker.title dayhome.name
      marker.picture({ :picture => "/assets/dayhome.png",
                       :width => 32,
                       :height => 37
                     })

    end
  end

  
end