class Search
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include GoogleMapsJsonHelper

  attr_accessor :address, :availability_types, :certification_types, :dietary_accommodations,
                :advanced_search, :pin_count, :day_homes, :search_pin, :auto_adjust

  DEFAULT_AVAILABILITY_TYPES = ['Full-time', 'Morning']
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
      update_checkboxes(attributes)
    else
      # check full and part time (either /searches or a simple search(header), visual for user)
      set_default_checkboxes
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

    # if the user uses the advanced search, we use the values from the availability type checkboxes,
    # otherwise we set the default to full/part time
    if params.has_key?(:advanced_search) && params[:advanced_search] == 'true'
      # apply where clauses
      dayhome_query = apply_type_filter(:availability_types, dayhome_query)
      dayhome_query = apply_type_filter(:certification_types, dayhome_query)
      dayhome_query = apply_boolean_filter(:dietary_accommodations, dayhome_query)
    else
      dayhome_query = dayhome_query.where("availability_types.kind IN (?)", DEFAULT_AVAILABILITY_TYPES).includes(:availability_types)
    end

    # create search dayhome pin
    if params.has_key?(:address) && !params[:address].blank?
      search_addy_pin = geocode(params[:address])
    end

    # return the gmaps pins variable
    create_pins(dayhome_query, search_addy_pin)
  end

private

  def calibrate_map
    #determine the autozoom
    if self.day_homes.nil?
      # no dayhomes found, focus in on edmonton
      self.auto_adjust = false
    elsif self.search_pin.nil?
      self.auto_adjust = true
    end
    #@search.auto_adjust
  end

  def apply_boolean_filter(boolean_column, dayhome_query)
    unless self.send(boolean_column).blank?
      # check if it's true
      if self.send(boolean_column) == '1'
        # tack on where clause
        dayhome_query = dayhome_query.where("day_homes.#{boolean_column} = true")
      end
    end
    dayhome_query
  end

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
    # set the default checkboxes (no search params entered))
    self.availability_types.each do |default_avail_types|
      DEFAULT_AVAILABILITY_TYPES.select do |def_avail|
        if def_avail =~ /^#{default_avail_types.kind}/
          default_avail_types.checked = true
        end
      end
    end
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
      kind_array = []
      self.send(type).each do |search_type|
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
    self.day_homes = dayhome_query.uniq.all

    # check if the user has entered to be near
    if search_addy_pin.nil?
      # save the number of pins
      self.pin_count = self.day_homes.count
    else
      # address exists, add 1 to the pin count
      self.pin_count = self.day_homes.count + 1

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
