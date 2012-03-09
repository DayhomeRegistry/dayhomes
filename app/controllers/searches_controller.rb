class SearchesController < ApplicationController

  def index
    # user goes directy to index page without search params
    if params[:search].blank?
      flash.now[:success] = "Displaying all dayhomes"

      # display all of the day homes
      @day_homes = DayHome.all.to_gmaps4rails
    else
      # determine which dayhomes to display
      dayhome_filter(params)
    end

    # make sure the search object keeps its persistance
    @advanced_search = params.has_key?(:search) ? Search.new(params[:search]) : Search.new
  end

  private

    def dayhome_filter(params)
      search_addy_pin = nil
      dayhome_query = DayHome.select('*')

      # make sure the address is clean
      if params.has_key?(:search) && params[:search].has_key?(:address) &&  params[:search][:address] != ''

        # create search dayhome pin
        search_addy_pin = geocode(params[:search][:address])
      end

      # make sure the enrollment key is clean
      if params.has_key?(:search) && params[:search].has_key?(:enrollment_open) &&  params[:search][:enrollment_open] != ''

        # get the dayhomes based on Open/Closed (true/false)
        if params[:search][:enrollment_open] == "true"
          dayhome_query = dayhome_query.where("enrolled < max_enrollment")
        else params[:search][:enrollment_open] == "false"
          dayhome_query = dayhome_query.where("enrolled = max_enrollment")
        end
      end

      @day_homes = create_pins(dayhome_query, search_addy_pin)
    end

    def create_pins(dayhome_query, search_addy_pin)
      # get all of the dayhomes from the system, convert to JSON array
      day_homes_json = dayhome_query.all.to_gmaps4rails
      day_home_array = ActiveSupport::JSON.decode(day_homes_json)

      unless search_addy_pin.nil?
        # add the search pin to the list of pins if it exists
        day_home_array = day_home_array << search_addy_pin
      end

      # convert it back to pure JSON for gmaps
      day_home_array.to_json
    end

    def geocode(address)
        begin
          # check to make sure address is valid
          Gmaps4rails.geocode(address)

          # grab the geolocation for where they searched
          search_address = Gmaps4rails.geocode(address)

          # convert hash to json (string)), decode json to ruby object
          search_pin = {:lat => search_address[0][:lat], :lng => search_address[0][:lng], :picture => '/assets/search_pin.png', :width => '32', :height => '37'}.to_json
          search_pin = ActiveSupport::JSON.decode(search_pin)
        rescue
          flash.now[:error] = "Unable to find dayhomes within that criteria"
          search_pin = nil
        end
        search_pin
      end
end