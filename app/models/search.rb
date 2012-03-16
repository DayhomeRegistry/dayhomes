class Search
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :address, :availability_types, :certification_types, :advanced_search, :pin_json, :pin_count

  def initialize(attributes = {})
    # set each of the attributes
    attributes.each do |name, value|
        send("#{name}=", value)
    end

    # override the models that were set with the attributes send loop
    self.availability_types = AvailabilityType.order('id asc').all
    self.certification_types = CertificationType.order('id asc').all

    # only do the availability type processing if you've submitted the advanced search form
    if self.advanced_search == 'true'
      update_checkboxes(attributes)
    else
      # check full and part time (either /searches or a simple search(header))
      set_default_checkboxes
    end
  end

  def dayhome_filter(params)
    search_addy_pin = nil
    dayhome_query = DayHome.scoped

    # morph the hash into the model
    search = Search.new(params)

    # set the joins based on what the user has
    dayhome_query = determine_joins(search, dayhome_query)

    # if the user uses the advanced search, we use the values from the availability type checkboxes,
    # otherwise we set the default to full/part time
    if search.advanced_search
      # apply where clauses
      dayhome_query = apply_type_filter(:availability_types, search, dayhome_query)
      dayhome_query = apply_type_filter(:certification_types, search, dayhome_query)
    else
      dayhome_query = dayhome_query.where("availability_types.kind IN (?)", ['Full-time', 'Part-time'])
    end

    # create search dayhome pin
    unless search.address.blank?
      search_addy_pin = geocode(search.address)
    end

    # return the gmaps pins variable
    create_pins(dayhome_query, search_addy_pin)
  end

private

  def persisted?
    false
  end

  def update_checkboxes(attributes)
    reset_all_checkboxes
    apply_checks(:availability_types, attributes)
    apply_checks(:certification_types, attributes)
  end

  def apply_checks(group, attr)
    if attr.has_key?(group)
      # grab intersect of user checkboxes and availability types
      ids = (attr[group][:kind] & self.send(group).map { |t| t.id.to_s })

      # update the checkboxes
      self.send(group).each do |type|
        ids.each do |id|
          # Set the checkboxes if the user has a checkbox checked, otherwise clear it out
          if type.id.to_s == id
            type.checked = true
          end

        end
      end
    end
  end

  def reset_all_checkboxes
    # clear out any existing values in the checkboxes
    # this is clean up after the simple search (set_default_checkboxes)
    self.availability_types.each do |clear_avail|
      clear_avail.checked = false
    end

    self.certification_types.each do |clear_avail|
      clear_avail.checked = false
    end
  end

  def set_default_checkboxes
    # set the default to part time and fulltime
    self.availability_types.each do |default_avail_types|
      if default_avail_types.kind == 'Full-time' || default_avail_types.kind == 'Part-time'
        default_avail_types.checked = true
      end
    end
  end

  def determine_joins(search, dayhome_query)
    # check if their are related entities (by looking for what's been checked), if so, join to that table
    has_avail_types = check_for_checks(:availability_types, search)
    has_cert_types = check_for_checks(:certification_types, search)

    # if any availability types are found apply the join
    if has_avail_types
      dayhome_query = dayhome_query.joins(:availability_types)
    end
    # if any certification types are found apply the join
    if has_cert_types
      dayhome_query = dayhome_query.joins(:certification_types)
    end

    dayhome_query
  end

  def check_for_checks(type, search)
    found_checkmark = false
    # if a search type is found break and return true
    search.send(type).each do |search_type|
      if search_type.checked == true
        found_checkmark = true
      end
    end

    found_checkmark
  end

  def apply_type_filter(type, search, dayhome_query)
    unless search.send(type).blank?
      # tack on any of the checkboxes to the where clause
      kind_array = []
      search.send(type).each do |search_type|
        if search_type.checked
          kind_array << "#{search_type.kind}"
        end
      end

      # check if any of the certification types are checked, if not we don't need a where clause here
      unless kind_array.empty?
        dayhome_query = dayhome_query.where("#{type}.kind IN (?)", kind_array)
      end
    end
    dayhome_query
  end

  def create_pins(dayhome_query, search_addy_pin)
    # get all of the dayhomes from the system
    day_homes = dayhome_query.uniq.all

    # save the number of pins
    self.pin_count = day_homes.count

    # convert to JSON array
    day_homes_json = day_homes.to_gmaps4rails
    day_home_array = ActiveSupport::JSON.decode(day_homes_json)

    unless search_addy_pin.nil?
      # add the search pin to the list of pins if it exists
      day_home_array = day_home_array << search_addy_pin

      # add 1 to the pin count
      self.pin_count = self.pin_count + 1
    end

    # convert it back to pure JSON for gmaps (and save it to the model))
    self.pin_json = day_home_array.to_json
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
      errors.add(:base,"Unable to find dayhomes within that criteria" )
      search_pin = nil
    end
    search_pin
  end

end
