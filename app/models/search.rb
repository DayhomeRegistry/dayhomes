class Search
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include GoogleMapsJsonHelper

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
      # check full and part time (either /searches or a simple search(header), visual for user)
      set_default_checkboxes
    end

    # no search params entered
    unless attributes.blank?
      # apply filter if we're searching
      dayhome_filter(attributes)
    end
  end

  def dayhome_filter(params)
    search_addy_pin = nil
    dayhome_query = DayHome.scoped

    # set the joins based on what the user has
    dayhome_query = determine_joins(params, dayhome_query)

    # if the user uses the advanced search, we use the values from the availability type checkboxes,
    # otherwise we set the default to full/part time
    if params.has_key?(:advanced_search) && params[:advanced_search] == 'true'
      # apply where clauses
      dayhome_query = apply_type_filter(:availability_types, params, dayhome_query)
      dayhome_query = apply_type_filter(:certification_types, params, dayhome_query)
    else
      dayhome_query = dayhome_query.where("availability_types.kind IN (?)", ['Full-time', 'Part-time'])
    end

    # create search dayhome pin
    if params.has_key?(:address) && !params[:address].blank?
      search_addy_pin = geocode(params[:address])
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

  def determine_joins(params, dayhome_query)
    # check if their are related entities (by looking for what's been checked), if so, join to that table
    has_avail_types = check_for_checks(:availability_types, params)
    has_cert_types = check_for_checks(:certification_types, params)

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

  def check_for_checks(type, params)
    found_checkmark = false

    self.send(type).each do |search_type|
      if search_type.checked == true
        found_checkmark = true
      end
    end

    found_checkmark
  end

  def apply_type_filter(type, params, dayhome_query)
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

    # add error due to no pins found (super restrictive criteria)
    if self.pin_count == 0
      errors.add(:base, "No dayhomes found within that criteria, remove some criteria to broden the search range" )
    end

    # convert it back to pure JSON for gmaps (and save it to the model))
    self.pin_json = day_home_array.to_json
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
