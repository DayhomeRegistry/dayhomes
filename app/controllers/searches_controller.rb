class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def create
    @search = Search.new

    begin
      # check to make sure address is valid
      Gmaps4rails.geocode(params[:search][:address])
    rescue
      # invalid address was entered
      @search.errors.add(:address, "is invalid")
      render :action => "new" and return
    end

    redirect_to :action => "index", :params => params[:search]
  end

  def index
    @search = Search.new

    # no address given, send them to new
    if params[:address].blank?
      render :action => "new" and return
    else
      # get all of the dayhomes from the system, convert to array
      day_homes_json = DayHome.all.to_gmaps4rails
      day_home_array = ActiveSupport::JSON.decode(day_homes_json)

      # grab the geolocation for where they searched
      search_address = Gmaps4rails.geocode(params[:address])

      # convert hash to json (string)), decode json to ruby object
      search_pin = {:lat => search_address[0][:lat], :lng => search_address[0][:lng]}.to_json
      search_pin = ActiveSupport::JSON.decode(search_pin)

      # add the search pin to the list of pins
      @day_homes = day_home_array << search_pin

      # convert back to json for gmaps
      @day_homes = @day_homes.to_json
    end
  end

end