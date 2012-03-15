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
  # clear out any existing values in the availability types
  # (clearing out any default values or anything of the like)
  self.availability_types.each do |clear_avail|
    clear_avail.checked = false
  end

  # save the checked items in the model
    if attributes.has_key?(:availability_types)
      attributes[:availability_types][:kind].each do |parm_avail_type|
        self.availability_types.each do |avail_type|

          # Set the checkboxes if the user has a checkbox checked, otherwise clear it out
          if avail_type.id.to_s == parm_avail_type
            avail_type.checked = true
          end
        end
      end
    end

    # save the checked items in the model
    #if attributes.has_key?(:certification_types)
    #  attributes[:certification_types][:kind].each do |parm_cert_type|
    #    self.certification_types.each do |cert_type|
    #
    #      # Set the checkboxes if the user has a checkbox checked, otherwise clear it out
    #      if cert_type.id.to_s == parm_cert_type
    #        cert_type.checked = true
    #      end
    #    end
    #  end
    #end

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
