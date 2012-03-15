class Search
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :address, :availability_types, :certification_types, :advanced_search, :pins

  def initialize(attributes = {}, *day_homes)
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

    # check if there's any pins, if so, save them to the model
    unless day_homes.nil?
      self.pins = day_homes
    end
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

end
