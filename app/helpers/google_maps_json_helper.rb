module GoogleMapsJsonHelper
  # Converts gmaps address into an array
  def convert_address(address)
    # check to make sure address is valid
    Gmaps4rails.geocode(address)

    # grab the geolocation for where they searched
    search_address = Gmaps4rails.geocode(address)

    # convert hash to array
    search_pin = {:lat => search_address[0][:lat], :lng => search_address[0][:lng], :picture => '/assets/search_pin.png', :width => '32', :height => '37'}.to_json
    ActiveSupport::JSON.decode(search_pin)
  end

  # combines a collection of gmappable AR models and an array
  def combine_coll_json(collection, obj_array)
    collection_json = collection.to_gmaps4rails
    collection_array = ActiveSupport::JSON.decode(collection_json)

    unless obj_array.nil?
      # add the search pin to the list of pins if it exists
      collection_array = collection_array << obj_array
    end

    collection_array.to_json
  end
end