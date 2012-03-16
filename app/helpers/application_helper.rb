module ApplicationHelper
  include GoogleMapsJson

  def yes_no(bool)
    bool ? 'Yes' : 'No'
  end
  
end
