module ApplicationHelper
  include ReCaptcha::ViewHelper
  
  def yes_no(bool)
    bool ? 'Yes' : 'No'
  end
  
  def fb_connect_button
    unless current_user
      link_to image_tag('fb_connect.gif'), omniauth_authorize_path(:user, :facebook), :alt => 'Connect with Facebook', :rel => 'nofollow'
    end
  end
  
  def sortable(column, title = nil, query="")

    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"    
    #link_to title, {:sort => column, :direction => direction}
    p = {'query'=>query}
    link_to url_for({:sort => column, :direction => direction, :params=>p}), {:class => css_class} do      
      if (column == sort_column)
        if (sort_direction == "asc")
          raw ("<div style='min-width:120px;'>#{title} <i class='fa fa-chevron-up'></i></div>")
        else
          raw ("<div style='min-width:120px;'>#{title} <i class='fa fa-chevron-down'></i></div>")
        end
      else
        raw (title + '&nbsp;')
      end
    end
  end

end
