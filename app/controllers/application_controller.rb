class ApplicationController < ActionController::Base
  include ReCaptcha::AppHelper
  
  before_filter :create_search
  #before_filter :validate_acknowledgement
  protect_from_forgery

  def create_search
    @search = Search.new
  end
  
  def validate_acknowledgement
    if(current_user)      
         # raise current_user.privacy_effective_date.to_s #+"<"+PrivacyPolicy.last.effective_date.to_s+"="+(current_user.privacy_effective_date<PrivacyPolicy.last.effective_date).to_s
      if(!current_user.privacy_effective_date || (current_user.privacy_effective_date<PrivacyPolicy.last.effective_date))        
      
        if(!request.fullpath.match(/^\/pages\/acknowledge/))
          #raise request.fullpath
          flash[:success]=render_to_string :partial=>"application/acknowledgement"
        end
        
      end
    end
  end
  
  helper_method :gmaps_api_key #:current_user_session, :current_user, 
  # ===============================
  # = User Authentication Related =
  # ===============================

  # def current_user_session
  #   return @current_user_session if defined?(@current_user_session)
  #   @current_user_session = UserSession.find
  # end

  # def current_user    
  #   #return @current_user if defined?(@current_user)
    
  #   #@current_user = current_user_session && current_user_session.user
  #   return current_user_session && current_user_session.user
  # end
  
  def require_user
    unless current_user
     # if current_user
     #   redirect_to logout_path
     # else
     #   session[:return_to] ="#{request.protocol}#{request.host_with_port}#{request.fullpath}"
     #   redirect_to login_path
     # end
 
     # return false
      authenticate_user!
    end
  end

  def require_no_user
    if current_user
      redirect_to root_path
      return false
    end
  end
  def require_user_to_be_organization_admin
    unless (current_user && current_user.organization_admin?)
      redirect_to root_path
    end
  end

  def require_user_to_be_site_admin
    unless current_user && current_user.admin?
      redirect_to root_path
    end
  end

  def gmaps_api_key
    if Rails.env.production?
      # return prod api key
      "AIzaSyB03go-dPecYfIzMYc1c9WFkK53QTiDwTA"
    else
      # return test/dev key
      "AIzaSyB03go-dPecYfIzMYc1c9WFkK53QTiDwTA"
    end
  end
  def after_sign_in_path_for(resource)
    if current_user && current_user.admin?
      admin_day_homes_path()
    else 
      day_homes_path()
    end
  end
end
