class ApplicationController < ActionController::Base
  before_filter :create_search
  before_filter :correct_safari_and_ie_accept_headers
  after_filter :set_xhr_flash
  protect_from_forgery

  def create_search
    @search = Search.new
  end
  
  helper_method :current_user_session, :current_user
  # ===============================
  # = User Authentication Related =
  # ===============================

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
  
  # Make sure they are an admin!
  def require_user
    unless current_user
     if current_user
       redirect_to logout_path
     else
       redirect_to login_path
     end
 
     return false
    end
  end

  def require_no_user
    if current_user
      redirect_to root_path
      return false
    end
  end

  def set_xhr_flash
    flash.discard if request.xhr?
  end

  def correct_safari_and_ie_accept_headers
    ajax_request_types = ['text/javascript', 'application/json', 'text/xml']
    request.accepts.sort! { |x, y| ajax_request_types.include?(y.to_s) ? 1 : -1 } if request.xhr?
  end

  def require_user_to_be_day_home_owner_or_admin
    unless (current_user && current_user.day_home_owner?) || (current_user && current_user.admin?)
      redirect_to root_path
    end
  end

end
