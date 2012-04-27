class Admin::ApplicationController < ApplicationController
  layout 'application'
  helper_method :current_user_session, :current_user
  before_filter :require_user
  
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
    if current_user && !current_user.admin?
      redirect_to admin_logout_path
      return false
    end

    unless current_user
     redirect_to admin_login_path
     return false
    end
  end

  def require_no_user
    if current_user
      redirect_to admin_root_path
      return false
    end
  end
  
end
