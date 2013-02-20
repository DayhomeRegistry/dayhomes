class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
    @user = User.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    
    if !(@user = User.find_by_email(params[:user_session]["email"]))
      @user = User.new
    end     
    
    if @user_session.save         
      if (!session[:return_to].nil?)
        url = session[:return_to]
        session[:return_to] = null
        return redirect_to url
      end
      if (@user.admin?)
        redirect_to admin_root_path
      else
        redirect_to day_homes_path
      end
    else
      flash[:error] = "Please enter a valid email and password combination."
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    @current_user_session = nil
    @user = nil
    redirect_to root_path
  end
  
  def fb_connect
    client = Koala::Facebook::OAuth.new(FACEBOOK_CONFIG[:app_id], FACEBOOK_CONFIG[:app_secret], fb_connect_callback_user_sessions_url)
    redirect_to client.url_for_oauth_code(:permissions => "email")
  end

  def fb_connect_callback
    client = Koala::Facebook::OAuth.new(FACEBOOK_CONFIG[:app_id], FACEBOOK_CONFIG[:app_secret], fb_connect_callback_user_sessions_url)
    access_token_info = client.get_access_token_info(params[:code])
    
    fb_access_token = access_token_info['access_token']
    fb_expires_in = access_token_info['expires']
    fb_user = Koala::Facebook::API.new(fb_access_token).get_object('me')
    
    if @user = User.find_by_email(fb_user['email'])
      @user.update_attribute(:facebook_access_token, fb_access_token)
      @user.update_attribute(:facebook_access_token_expires_in, fb_expires_in)

      UserSession.new(@user).save
    else
      @user = User.new_from_fb_user(fb_user, fb_access_token, fb_expires_in)
      if @user.save
        UserSession.new(@user).save
      else
        flash[:error] = "Someting went wrong while trying to log you in with facebook. Please try again."
      end
    end
    
    redirect_to root_path
  end
  
end