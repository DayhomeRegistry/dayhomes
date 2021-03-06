class PasswordResetsController < ApplicationController
  before_filter :require_no_user, :except => [:admin_reset]
  skip_before_filter :require_user
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  
  def new
    url = session[:return_to]
  end
  
  def admin_reset
    @user = User.find(params[:id])
    if @user && @user.deliver_password_reset_instructions!
      flash[:success] = "Instructions to reset their password have been emailed to #{@user.email}."
    else
      flash[:error] = "Oops, we couldn't find an email for that user."
    end
    flash.keep
    redirect_to :controller=>'users',:action=>'index'
  end

  def create

    @user = User.find_by_email(params[:email])
    
    if @user && @user.deliver_password_reset_instructions!
      flash[:success] = "Instructions for a password reset have been emailed to #{@user.email}."
      redirect_to login_path
    else
      flash.now[:error] = "No user was found for #{params[:email]}"
      render :action => :new
    end
  end
  
  def edit
    url = session[:return_to]
  end

  def update    
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    
    if @user.save
      @user_session = UserSession.new(@user)
      if @user_session.save
        if (!session[:return_to].nil?)
          url = session[:return_to]
          session[:return_to] = nil
          return redirect_to url
        end
      end
      redirect_to root_path

    else
      render :action => :edit
    end
  end

  private

  def load_user_using_perishable_token
    @user = User.find_by_single_access_token(params[:id])
    
    unless @user
      flash[:warning] = "We were unable to locate your account. If you're having issues try " +
      "copying and pasting the URL from your email into your browser or requesting your password again."
      redirect_to root_path
    end
  end
  
end