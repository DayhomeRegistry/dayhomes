class SearchesController < ApplicationController

  def index
    # no address given, send them to new
    if params[:search].blank? || params[:search][:address].blank?
      flash[:error] = "Address not entered, no search pin dropped"

      # display all of the day homes
      @day_homes = DayHome.all.to_gmaps4rails
    else
      begin
        # check to make sure address is valid
        Gmaps4rails.geocode(params[:search][:address])

        # get all of the dayhomes from the system, convert to array
        day_homes_json = DayHome.all.to_gmaps4rails
        day_home_array = ActiveSupport::JSON.decode(day_homes_json)

        # grab the geolocation for where they searched
        search_address = Gmaps4rails.geocode(params[:search][:address])

        # convert hash to json (string)), decode json to ruby object
        search_pin = {:lat => search_address[0][:lat], :lng => search_address[0][:lng], :picture => '/assets/search_pin.png', :width => '32', :height => '37'}.to_json
        search_pin = ActiveSupport::JSON.decode(search_pin)

        # add the search pin to the list of pins
        @day_homes = day_home_array << search_pin

        # convert back to json for gmaps
        @day_homes = @day_homes.to_json
      rescue
        flash[:error] = "Unable to find address, no search pin dropped"

        # display all of the day homes
        @day_homes = DayHome.all.to_gmaps4rails
      end

    end
  end


end