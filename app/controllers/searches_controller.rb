class SearchesController < ApplicationController

  def index

    u = User.create!({:email => 'dayadmin@dayhome422registry.com', :password => 'day4admin', :password_confirmation => 'day4admin', :first_name => 'DayHome', :last_name => 'Admin', :admin => true})
    u.first_name = 'test'
    # user goes directy to index page without search params
    if params[:search].blank?
      flash.now[:success] = "Displaying all dayhomes"

      # display all of the full and part time
      @day_homes = DayHome.select('*').joins(:day_home_availability_types, :availability_types)
        .where("kind IN (?)", ['Full-time', 'Part-time']).to_gmaps4rails
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
      dayhome_query = DayHome.select('*').joins(:day_home_availability_types, :availability_types)

      # morph the hash into the model
      search = Search.new(params[:search])

      # create search dayhome pin
      unless search.address.blank?
        search_addy_pin = geocode(params[:search][:address])
      end

      # tack on any of the checkboxes to the where clause
      availability_kind_array = []
      search.availability_types.each do |search_avil_type|
        if search_avil_type.checked
          availability_kind_array << "#{search_avil_type.kind}"
        end
      end

      # feed thw here clause an in (OR)
      unless availability_kind_array.empty?
        dayhome_query = dayhome_query.where("kind IN (?)", availability_kind_array)
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