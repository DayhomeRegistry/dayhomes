class PasswordResetsController < ApplicationController
  before_filter :require_no_user
  skip_before_filter :require_user
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  
  def new
  end
  
  def create
    @user = User.find_by_email(params[:email])
    
    if @user && @user.deliver_password_reset_instructions!
      flash[:notice] = "Instructions to reset your password have been emailed to #{@user.email}."
      redirect_to root_path
    else
      flash.now[:error] = "No user was found for #{params[:email]}"
      render :action => :new
    end
  end
  
  def edit
  end

  def update    
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    
    if @user.save
      @user_session = UserSession.new(@user)
      if @user_session.save
        redirect_to root_path
      else
        redirect_to root_path
      end

    else
      render :action => :edit
    end
  end

  private

  def load_user_using_perishable_token
    @user = User.find_by_single_access_token(params[:id])
    
    unless @user
      flash[:notice] = "We were unable to locate your account. If you're having issues try " +
      "copying and pasting the URL from your email into your browser or requesting your password again."
      redirect_to root_path
    end
  end
  
end