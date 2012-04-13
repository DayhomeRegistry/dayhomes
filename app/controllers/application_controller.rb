class ApplicationController < ActionController::Base
  before_filter :create_search
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

end
