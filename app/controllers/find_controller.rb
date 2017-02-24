#AIzaSyDYPLQjWeUWSe3H-420NOPNP7K1wRn0yyE

class FindController < ApplicationController
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

    @search = Search.new(attributes)
    
  	@advanced_search = params.has_key?(:search) ? @search : Search.new
  	
  end
  def markers 
  	respond_to do |format|
	  format.js {
	  	bounds = params[:bounds]
    	box = [bounds["SW"]["lat"].to_f,bounds["SW"]["lng"].to_f,bounds["NE"]["lat"].to_f,bounds["NE"]["lng"].to_f]

    	search = params[:search]
    	
	    attributes = search[:search] || Hash.new
	   	
		@search = Search.new(attributes)

	 	#Shrink to just the box
	 	@hits = @search.day_homes #DayHome.joins(:availability_types)
	  	@hits = @hits.within_bounding_box(box)
	  	
	    render json: {markers: @hits } #, featured:@featured }
	  }
	end
  end
  def featured 
  	respond_to do |format|
	  format.js {
	  	bounds = params[:bounds]
    	box = [bounds["SW"]["lat"].to_f,bounds["SW"]["lng"].to_f,bounds["NE"]["lat"].to_f,bounds["NE"]["lng"].to_f]

    	search = params[:search]
	    attributes = search[:search] || Hash.new
	   	
		@search = Search.new(attributes)

	 	hits = @search.featured
	  	@featured = hits.within_bounding_box(box)

	    render json: {data: (render_to_string partial: '/find/featured', locals: {featured: @featured}, layout: false ) } 
	  }
	end
  end
  def details 
  	respond_to do |format|
	  format.js {
	  	bounds = params[:bounds]
    	box = [bounds["SW"]["lat"].to_f,bounds["SW"]["lng"].to_f,bounds["NE"]["lat"].to_f,bounds["NE"]["lng"].to_f]

    	search = params[:search]
	    attributes = search[:search] || Hash.new
	   	
		@search = Search.new(attributes)

	 	hits = @search.day_homes
	  	@hits = hits.within_bounding_box(box)

	  	#byebug
	    render json: {data: (render_to_string partial: '/find/details', locals: {hits: @hits}, layout: false ) } 
	  }
	end
  end

  def infowindow
    day_home = DayHome.find_by_id(params[:day_home_id])
    @agencies = Organization.joins(:day_homes).group('organization_id').having('count(day_homes.id)>1')
    render :partial => "/find/pin", :locals => { :dayhome => day_home}
  end
  def build_dayhome_tile
    day_home = DayHome.find_by_id(params[:day_home_id])
    if(day_home)
      respond_to do |format|
          format.html {
            render json: 'Dayhome is valid.'
          }
          format.js { 
            render :partial => "/find/day_home", :locals => { :day_home => day_home}
          }
      end
    else
      respond_to do |format|
          format.html {
            render json: 'Dayhome is invalid.'
          }
          format.js { 
            render :nothing => true, :status => 500, :content_type => 'text/html'
          }
      end
    end
  end

  private
    def getHash(location) 
      hash = {}
      hash[:lat]= !location.nil? ? location.latitude : 0
      hash[:lng]= !location.nil? ? location.longitude : 0
      hash
    end
    def getKinds(option)
    	kinds = {}
	    #attributes["location"]=Geocoder.search("Calgary").first.data["geometry"]["location"]

		# "availability_types":{"kind":["1","2","3","4","5","6","7","8"]}
		# <option value="1">All spots</option>
		# <option value="2">Full time</option> 1,2,3
		# <option value="3">Part time</option> 4,5,6,7,8
		# <option value="4">Before/After School</option> 2,3,7,8
	    type = 1
	    if(!option.nil? && option.to_i>1)
	      type = option.to_i
		end
		#{}"availability_types"=>{"kind"=>["4", "5", "6", "7", "8"]}
		#AvailabilityType.all
		if(type==2)
			# kinds.each do |type|
			#   if([1,2,3].include?(type.id))
			#     type.checked = true
			#   end
			# end
			kinds["kind"]=[1,2,3]
		elsif(type==3)
			# kinds.each do |type|
			#   if([4,5,6,7,8].include?(type.id))
			#     type.checked = true
			#   end
			# end
			kinds["kind"]=[4,5,6,7,8]
		elsif(type==4)
			# kinds.each do |type|
			#   if([2,3,7,8].include?(type.id))
			#     type.checked = true
			#   end
			# end
			kinds["kind"]=[2,3,7,8]
		else
			kinds["kind"]=[1,2,3,4,5,6,7,8]
		end
		
	    logger.debug '*************************************************************'
	    logger.debug kinds
		logger.debug '*************************************************************'

	    kinds["kind"]

    end
end