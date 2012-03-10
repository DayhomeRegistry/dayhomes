class Search
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :address, :availability_types

  def initialize(attributes = {})
    # set the availability types
    self.availability_types = AvailabilityType.order('kind asc').all

    # "set" each of the attributes
    attributes.each do |name, value|

      # don't update the availabilty_type checkboxes to an array
      unless name == 'availability_types'
        send("#{name}=", value)
      end
    end

    ##TODO maybe a check for only advanced search page?

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

  def persisted?
    false
  end
end
