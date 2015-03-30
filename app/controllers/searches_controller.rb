class SearchesController < ApplicationController
  def index

    attributes = params[:search] || Hash.new
    attributes[:location]=getHash(request.location)
    #attributes["location"]=Geocoder.search("Calgary").first.data["geometry"]["location"]

    if(!params["spots"].nil? && params["spots"].to_i>1)
      type = params["spots"].to_i
      # "availability_types":{"kind":["1","2","3","4","5","6","7","8"]}
      # <option value="1">All spots</option>
      # <option value="2">Full time</option> 1,2,3
      # <option value="3">Part time</option> 4,5,6,7,8
      # <option value="4">Before/After School</option> 2,3,7,8

      #{}"availability_types"=>{"kind"=>["4", "5", "6", "7", "8"]}
      kinds = {}#AvailabilityType.all
      # kinds["kind"] 
      if(type==2)
        # kinds.each do |type|
        #   if([1,2,3].include?(type.id))
        #     type.checked = true
        #   end
        # end
        kinds["kind"]=["1","2","3"]
        attributes["availability_types"] = kinds
      elsif(type==3)
        # kinds.each do |type|
        #   if([4,5,6,7,8].include?(type.id))
        #     type.checked = true
        #   end
        # end
        kinds["kind"]=["4","5","6","7","8"]
        attributes["availability_types"] = kinds
      else
        # kinds.each do |type|
        #   if([2,3,7,8].include?(type.id))
        #     type.checked = true
        #   end
        # end
        kinds["kind"]=["2","3","7","8"]
        attributes["availability_types"] = kinds
      end
      # attributes["availability_types"] = kinds
    end
    #byebug
    #{"address"=>"", "location"=>{"lat"=>43.643, "lng"=>-79.388}}
    # logger.info "*********************************************"
    # logger.info request.remote_ip
    # logger.info attributes
    # logger.info "*********************************************"
    @search = Search.new(attributes)

    # If any errors, show an error message
    if @search.errors.count > 1
      flash.now[:error] = "Unable to find dayhomes within that criteria, please modifying the critera to be less restrictive"
    elsif @search.errors.count == 1
      flash.now[:error] = @search.errors[:base][0]
    end

    # set the pins for gmaps
    #@featured = DayHome.featured
    @day_homes = @search.day_homes

    #@featured = @day_homes.reject {|dayhome| !dayhome.featured?}
    @featured = @search.featured
    @agencies = Organization.joins(:day_homes).group('organization_id').having('count(day_homes.id)>1')
    #gmaps hash
    @hash = Gmaps4rails.build_markers(@day_homes) do |day_home, marker|
      marker.lat day_home.lat
      marker.lng day_home.lng
      marker.infowindow day_home.blurb
      if @featured.include?(day_home)
        picture = ActionController::Base.helpers.asset_path("dayhome-private-featured.png")
        picture = ActionController::Base.helpers.asset_path("dayhome-featured.png") unless !day_home.licensed
        picture = ActionController::Base.helpers.asset_path("dayhome-premium-featured.png") unless day_home.organization.pin.nil?
      else
        picture = ActionController::Base.helpers.asset_path("dayhome-private.png")
        picture = ActionController::Base.helpers.asset_path("dayhome.png") unless !day_home.licensed
        picture = day_home.organization.pin.photo_url(:pin) unless day_home.organization.pin.nil?
      end
      marker.picture({ :url => picture,
                       :width => 41,
                       :height => 45
                     })
      marker.infowindow render_to_string(:partial => "/searches/pin", :locals => { :dayhome => day_home})
      marker.title render_to_string(:partial => "/searches/day_home", :locals => { :day_home => day_home})
    end

    # make sure the search object keeps its persistance
    @advanced_search = params.has_key?(:search) ? @search : Search.new
  end
  
  private
    def getHash(location) 
      hash = {}
      hash[:lat]= location.latitude
      hash[:lng]=location.longitude
      hash
    end
end