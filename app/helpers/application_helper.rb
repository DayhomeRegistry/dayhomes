module ApplicationHelper
  include ReCaptcha::ViewHelper
  
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
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"    
    #link_to title, {:sort => column, :direction => direction}
    link_to url_for({:sort => column, :direction => direction}), {:class => css_class} do      
      if (column == sort_column)
        if (sort_direction == "asc")
          raw ("<div style='min-width:100px;'>#{title}<i class='icon-chevron-up'></i></div>")
        else
          raw ("<div style='min-width:100px;'>#{title}<i class='icon-chevron-down'></i></div>")
        end
      else
          title
      end
    end
  end

end
