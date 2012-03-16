# Converts items to gmaps json
module GoogleMapsJson
  def convert_address(address)
    # check to make sure address is valid
    Gmaps4rails.geocode(address)

    # grab the geolocation for where they searched
    search_address = Gmaps4rails.geocode(address)

    # convert hash to json (string)), decode json to ruby object
    search_pin = {:lat => search_address[0][:lat], :lng => search_address[0][:lng], :picture => '/assets/search_pin.png', :width => '32', :height => '37'}.to_json
    ActiveSupport::JSON.decode(search_pin)
  end
end