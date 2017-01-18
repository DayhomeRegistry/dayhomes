#AIzaSyDYPLQjWeUWSe3H-420NOPNP7K1wRn0yyE

class FindController < ApplicationController
  def index
 #  	$attributes = params[:search] || Hash.new
 #    #attributes["location"]=Geocoder.search("Calgary").first.data["geometry"]["location"]

	# # "availability_types":{"kind":["1","2","3","4","5","6","7","8"]}
	# # <option value="1">All spots</option>
	# # <option value="2">Full time</option> 1,2,3
	# # <option value="3">Part time</option> 4,5,6,7,8
	# # <option value="4">Before/After School</option> 2,3,7,8
 #    type = 1
 #    if(!params["spots"].nil? && params["spots"].to_i>1)
 #      type = params["spots"].to_i
	# end
	# #{}"availability_types"=>{"kind"=>["4", "5", "6", "7", "8"]}
	# kinds = {}#AvailabilityType.all
	# if(type==2)
	# 	# kinds.each do |type|
	# 	#   if([1,2,3].include?(type.id))
	# 	#     type.checked = true
	# 	#   end
	# 	# end
	# 	kinds["kind"]=["1","2","3"]
	# elsif(type==3)
	# 	# kinds.each do |type|
	# 	#   if([4,5,6,7,8].include?(type.id))
	# 	#     type.checked = true
	# 	#   end
	# 	# end
	# 	kinds["kind"]=["4","5","6","7","8"]
	# elsif(type==4)
	# 	# kinds.each do |type|
	# 	#   if([2,3,7,8].include?(type.id))
	# 	#     type.checked = true
	# 	#   end
	# 	# end
	# 	kinds["kind"]=["2","3","7","8"]
	# end
	# $attributes["availability_types"] = kinds

 #    logger.debug '*************************************************************'
 #    logger.debug $attributes
	# logger.debug '*************************************************************'
    

  	
  end
  def markers 
  	respond_to do |format|
	  format.js {
	  	bounds = params[:bounds]
    	box = [bounds["SW"]["lat"].to_f,bounds["SW"]["lng"].to_f,bounds["NE"]["lat"].to_f,bounds["NE"]["lng"].to_f]
    	logger.debug '*************************************************************'
    	logger.debug bounds["SW"]["lat"].to_f
	    logger.debug box
		logger.debug '*************************************************************'
    	search = params[:search]
	    # attributes = search[:search] || Hash.new
	    # attributes[:location]=getHash(request.location)
	    # attributes[:bounds]=box

	 #    distance = 20
		# center_point = [50.73621069076882, -113.96832268685102]
	 #    box = Geocoder::Calculations.bounding_box(center_point, distance)
	 #    #[50.44674712454712, -114.4256893646904, 51.02567425699052, -113.51095600901165]
	 #    logger.debug '*************************************************************'
	 #    logger.debug box
		# logger.debug '*************************************************************'
	  	@hits = DayHome.within_bounding_box(box)
	    #render json: {markers: [{lat: 50.73621069076882, lng: -113.96832268685102},{lat: 50.736346494394, lng: -113.97398751229048},{lat: 50.674938, lng: -113.974908}]}
	    render json: {markers: @hits}
	  }
	end
  end

  private
    def getHash(location) 
      hash = {}
      hash[:lat]= !location.nil? ? location.latitude : 0
      hash[:lng]= !location.nil? ? location.longitude : 0
      hash
    end
end