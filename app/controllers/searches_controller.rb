class SearchesController < ApplicationController
  def index

    attributes = params[:search]
    attributes["location"]=getHash(request.location)
    #attributes["location"]=Geocoder.search("Calgary").first.data["geometry"]["location"]

    #debugger
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
    #debugger
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
    @featured = @day_homes.reject {|dayhome| !dayhome.featured?}
    

    # make sure the search object keeps its persistance
    @advanced_search = params.has_key?(:search) ? @search : Search.new
  end
  
  private
    def getHash(location) 
      hash = {}
      hash["lat"]=location.latitude
      hash["lng"]=location.longitude
      hash
    end
end