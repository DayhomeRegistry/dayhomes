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
    self.availability_types = AvailabilityType.order('kind asc').all

    # only get the availability type processing if you're on the advanced form
    if self.advanced_search == 'true'
      # save the checked items in the model
      if attributes.has_key?(:availability_types)
        attributes[:availability_types][:kind].each do |parm_avail_type|
          self.availability_types.each do |avail_type|

            # Set the checkboxes if the user has a checkbox checked
            if (avail_type.id.to_s == parm_avail_type)
              avail_type.checked = true
            end
          end
        end
      end

    end
  end

  def persisted?
    false
  end
end
