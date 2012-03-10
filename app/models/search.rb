class Search
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :address, :availability_types, :advanced_search

  def initialize(attributes = {})
    # set each of the attributes
    attributes.each do |name, value|
        send("#{name}=", value)
    end

    # override the availability types array (checkboxes)) with the actual AvailabilityType models
    self.availability_types = AvailabilityType.order('id asc').all

    # only do the availability type processing if you've submitted the advanced search form
    if self.advanced_search == 'true'
      update_checkboxes(attributes)
    else
      # check full and part time (either /searches or a simple search(header))
      set_default_checkboxes
    end
  end

private

  def persisted?
    false
  end

  def update_checkboxes(attributes)
  # save the checked items in the model
      if attributes.has_key?(:availability_types)
        attributes[:availability_types][:kind].each do |parm_avail_type|
          self.availability_types.each do |avail_type|

            # Set the checkboxes if the user has a checkbox checked, otherwise clear it out
            if (avail_type.id.to_s == parm_avail_type)
              avail_type.checked = true
            end
          end
        end
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
