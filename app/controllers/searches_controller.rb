class SearchesController < ApplicationController

  def index
    # user goes directy to index page without search params
    if params[:search].blank?
      # display all of the full and part time
      @day_homes = DayHome.select('*').joins(:day_home_availability_types, :availability_types)
        .where("availability_types.kind IN (?)", ['Full-time', 'Part-time']).group("day_homes.id").all.to_gmaps4rails
    else
      # determine which dayhomes to display
      dayhome_filter(params)
    end

    # make sure the search object keeps its persistance
    @advanced_search = params.has_key?(:search) ? Search.new(params[:search], @day_homes) : Search.new
  end

  private

    def dayhome_filter(params)
      search_addy_pin = nil
      dayhome_query = DayHome.select('*')

      # morph the hash into the model
      search = Search.new(params[:search])

      # if the user uses the advanced search, we use the values from the availability type checkboxes,
      # otherwise we set the default to full/part time
      if search.advanced_search
        # set the joins based on what the user has
        dayhome_query = determine_joins(search, dayhome_query)

        # apply where clauses
        dayhome_query = apply_availabilty_type_filter(search, dayhome_query)
        dayhome_query = apply_certification_type_filter(search, dayhome_query)
      else
        dayhome_query = dayhome_query.where("availability_types.kind IN (?)", ['Full-time', 'Part-time'])
      end

      # create search dayhome pin
      unless search.address.blank?
        search_addy_pin = geocode(search.address)
      end

      # populate the gmaps pins variable
      @day_homes = create_pins(dayhome_query, search_addy_pin)
    end

    def determine_joins(search, dayhome_query)
      # check if their are related entities (by looking for what's been checked), if so, join to that table
      has_avail_types = false
      has_cert_types = false

      # check for checked availability types
      search.availability_types.each do |avail_type|
        if avail_type.checked == true
          has_avail_types = true
        end
      end

      # check for checked certification types
      search.certification_types.each do |cert_type|
        if cert_type.checked == true
          has_cert_types = true
        end
      end

      # if any are found apply the join
      if has_avail_types
        dayhome_query = dayhome_query.joins(:day_home_availability_types, :availability_types)
      end
      # if any are found apply the join
      if has_cert_types
        dayhome_query = dayhome_query.joins(:day_home_certification_types, :certification_types)
      end

      dayhome_query
    end

    def apply_certification_type_filter(search, dayhome_query)
      unless search.certification_types.blank?
        # tack on any of the checkboxes to the where clause
        certification_kind_array = []
        search.certification_types.each do |search_cert_type|
          if search_cert_type.checked
            certification_kind_array << "#{search_cert_type.kind}"
          end
        end

        # check if any of the certification types are checked, if not we don't need a where clause here
        unless certification_kind_array.empty?
          dayhome_query = dayhome_query.where("certification_types.kind IN (?)", certification_kind_array)
        end
      end
      dayhome_query
    end

    def apply_availabilty_type_filter(search, dayhome_query)
      unless search.availability_types.blank?
        # tack on any of the checkboxes to the where clause
        availability_kind_array = []
        search.availability_types.each do |search_avil_type|
          if search_avil_type.checked
            availability_kind_array << "#{search_avil_type.kind}"
          end
        end

        # check if any of the availability types are checked, if not we don't need a where clause here
        unless availability_kind_array.empty?
          dayhome_query = dayhome_query.where("availability_types.kind IN (?)", availability_kind_array)
        end
      end
      dayhome_query
    end


    def create_pins(dayhome_query, search_addy_pin)
      # get all of the dayhomes from the system, convert to JSON array
      day_homes_json = dayhome_query.group("day_homes.id").all.to_gmaps4rails

      day_home_array = ActiveSupport::JSON.decode(day_homes_json)

      unless search_addy_pin.nil?
        # add the search pin to the list of pins if it exists
        day_home_array = day_home_array << search_addy_pin
      end

      # convert it back to pure JSON for gmaps
      @day_homes = day_home_array.to_json
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