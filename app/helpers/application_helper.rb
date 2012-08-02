module ApplicationHelper

  def yes_no(bool)
    bool ? 'Yes' : 'No'
  end
  
  def fb_connect_button
    unless current_user
      link_to image_tag('fb_connect.gif'), [:fb_connect, :user_sessions], :alt => 'Connect with Facebook', :rel => 'nofollow'
    end
  end
  
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end
  
end
