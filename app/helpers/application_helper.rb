module ApplicationHelper

  def yes_no(bool)
    bool ? 'Yes' : 'No'
  end
  
  def fb_connect_button
    unless current_user
      link_to image_tag('fb_connect.gif'), [:fb_connect, :user_sessions], :alt => 'Connect with Facebook', :rel => 'nofollow'
    end
  end
  
end
