class Search
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include GoogleMapsJsonHelper

  attr_accessor :address, :availability_types, :certification_types, :dietary_accommodations,
                :advanced_search, :pin_count, :day_homes, :search_pin, :auto_adjust, :center_latitude,
                :center_longitude, :zoom, :licensed, :unlicensed, :both_license_types, :license_group

  DEFAULT_AVAILABILITY_TYPES = {:availability => ['Full-time', 'Part-time'], :kind => 'Full Days'}
  EDMONTON_GEO = {:lat => 53.543564, :lng => -113.507074 }

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
      # update search vars based on checkboxes
      update_check_boxes(attributes)

      # update the search vars based on the license radio button group
      unless self.license_group.blank?
        self.send("#{self.license_group}=", true)
      end
    else
      # set search defaults (either /searches or a simple search(header))
      set_defaults
    end

    # no search params entered
    unless attributes.blank?
      # apply filter if we're searching
      dayhome_filter(attributes)
    end

    # determine map settings
    calibrate_map
  end

  def dayhome_filter(params)
    search_addy_pin = nil
    dayhome_query = DayHome.scoped

    # set the joins based on what the user has
    dayhome_query = determine_joins(dayhome_query)

    # if the user uses the advanced search, we use the values from the search screen
    # otherwise we use the defaults (defined in set_defaults)
    if params.has_key?(:advanced_search) && params[:advanced_search] == 'true'
      # apply where clauses
      dayhome_query = apply_type_filter(:availability_types, dayhome_query)
      dayhome_query = apply_type_filter(:certification_types, dayhome_query)
      dayhome_query = apply_boolean_filter(:dietary_accommodations, dayhome_query)
      dayhome_query = apply_licensed_filter(dayhome_query)
    else
      dayhome_query = dayhome_query.where("availability_types.availability IN (?) AND availability_types.kind = ?", DEFAULT_AVAILABILITY_TYPES[:availability], DEFAULT_AVAILABILITY_TYPES[:kind]).includes(:availability_types)
      dayhome_query = dayhome_query.where(:licensed => [true, false])
    end

    # create search dayhome pin
    if params.has_key?(:address) && !params[:address].blank?
      search_addy_pin = geocode(params[:address])
    end

    # return the gmaps pins variable
    create_pins(dayhome_query, search_addy_pin)
  end
  
  
  def address=(addr_value='')
    # hack for ie7 due to placeholder being submitted
    if addr_value =~ /Address or Neighbourhood/
      addr_value = ''
    end

    # If no major candian city in query - add alberta as default.
    unless addr_value.downcase =~ /edmonton/
      addr_value += ' Edmonton'
    end
    
    # If no canadian province in query - add alberta as default.
    unless addr_value.include?('alberta') && addr_value.include?('ab')
      addr_value += ' Alberta'
    end
    
    @address = addr_value
  end
  
private

  def calibrate_map
    # determine the autozoom
    if self.day_homes.blank? || self.search_pin
      # disable auto adjust so we can focus in on a location (either edmonton, or the search pin location)
      self.auto_adjust = false
    elsif self.day_homes || self.search_pin.nil?
      # no search pin entered and dayhomes are found, let the map position itself around the pins
      self.auto_adjust = true
    end

    # check where to position the map
    if self.search_pin.nil?
      # if the search pin isn't found send it to the center of edmonton
      self.center_latitude = Search::EDMONTON_GEO[:lat]
      self.center_longitude = Search::EDMONTON_GEO[:lng]
      self.zoom = 11
    else
      # send them to the lat long of where they searched
      self.center_latitude = self.search_pin["lat"]
      self.center_longitude = self.search_pin["lng"]
      self.zoom = 12
    end
  end

  def apply_boolean_filter(boolean_column, dayhome_query)
    unless self.send(boolean_column).blank?
      # check if the box is checked on the screen
      if self.send(boolean_column) == '1'
        # tack on where clause
        dayhome_query = dayhome_query.where("day_homes.#{boolean_column} = true")
      end
    end
    dayhome_query
  end

  # apply the where clauses based on which radio button is selected
  def apply_licensed_filter(dayhome_query)
    if !self.licensed.blank? && self.licensed  == true
      dayhome_query = dayhome_query.where("day_homes.licensed = true")
    elsif !self.unlicensed.blank? && self.unlicensed == true
      dayhome_query = dayhome_query.where("day_homes.licensed = false")
    elsif !self.both_license_types.blank? && self.both_license_types == true
      # if the other 2 aren't set, it must be both
      dayhome_query = dayhome_query.where(:licensed => [true, false])
    end

    dayhome_query
  end

  def persisted?
    false
  end

  def update_check_boxes(attributes)
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
    # this is clean up after the simple search (set_defaults)
    self.availability_types.each do |clear_avail|
      clear_avail.checked = false
    end

    self.certification_types.each do |clear_avail|
      clear_avail.checked = false
    end
  end

  # set the defaults (no search params entered))
  def set_defaults
    self.availability_types.each do |default_avail_types|
      if DEFAULT_AVAILABILITY_TYPES[:kind] =~ /^#{default_avail_types.kind}/
        default_avail_types.checked = true
      end
    end

    self.both_license_types = true
  end

  def determine_joins(dayhome_query)
    # check if their are related entities (by looking for what's been checked), if so, join to that table
    has_avail_types = check_for_checks(:availability_types)
    has_cert_types = check_for_checks(:certification_types)

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

  def check_for_checks(type)
    found_checkmark = false

    self.send(type).each do |search_type|
      if search_type.checked
        found_checkmark = true
      end
    end

    found_checkmark
  end

  def apply_type_filter(type, dayhome_query)
    unless self.send(type).blank?
      # tack on any of the checkboxes to the where clause
      id_array = []
      self.send(type).each do |search_type|
        if search_type.checked
          id_array << "#{search_type.id}"
        end
      end

      # check if any of the types are checked, if not we don't need a where clause here
      unless id_array.empty?
        dayhome_query = dayhome_query.where("#{type}.id IN (?)", id_array)
      end

    end
    dayhome_query
  end

  def create_pins(dayhome_query, search_addy_pin)
    # get all of the dayhomes from the system
    self.day_homes = dayhome_query.uniq.all

    # record the number of pins
    self.pin_count = self.day_homes.count

    # check if the user has entered to be near
    unless search_addy_pin.nil?
      # save the search pin within search
      self.search_pin = search_addy_pin
    end

    # add error due to no pins found (super restrictive criteria)
    if self.pin_count == 0
      errors.add(:base, "No dayhomes found within that criteria, remove some criteria to broden the search range" )
    end

  end

  def geocode(address)
    begin
      # get the json representation of an address
      search_pin = convert_address(address)
    rescue
      errors.add(:base, "Unable to find dayhomes within that criteria, please try a different address near the location you're searching for" )
      search_pin = nil
    end
    search_pin
  end

end
