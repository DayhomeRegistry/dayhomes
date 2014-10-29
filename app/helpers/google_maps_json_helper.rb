module GoogleMapsJsonHelper
  # Converts gmaps address into a hash
  def convert_address(address)
    # check to make sure address is valid
    Gmaps4rails.geocode(address)

    # grab the geolocation for where they searched
    search_address = Gmaps4rails.geocode(address)

    # convert JSON into hash
    search_pin = {:lat => search_address[0][:lat], :lng => search_address[0][:lng], :width => '32', :height => '37'}.to_json
    ActiveSupport::JSON.decode(search_pin)
  end

  # combines a collection of gmappable AR models and a hash
  def combine_coll_json(collection, obj_hash)
    collection_json = collection.to_gmaps4rails
    collection_array = ActiveSupport::JSON.decode(collection_json)

    unless obj_hash.nil?
      # add the search pin to the list of pins if it exists
      collection_array = collection_array << obj_hash
    end

    collection_array.to_json
  end
  
  def gmap_prepare_dayhomes(day_homes)
    day_homes.to_gmaps4rails do |dayhome, marker|
      marker.infowindow render(:partial => "/searches/pin", :locals => { :dayhome => dayhome})
      marker.title dayhome.name
      picture = "/assets/dayhome-private.png"
      picture = "/assets/dayhome.png" unless !dayhome.licensed
      picture = dayhome.organization.pin.photo_url(:pin) unless dayhome.organization.pin.nil?

      marker.picture({ :picture => picture,
                       :width => 32,
                       :height => 37
                     })
      marker.sidebar render(:partial => "/searches/day_home", :locals => { :day_home => dayhome})
    end
  end
end