class Admin::UserSessionsController < Admin::ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  skip_before_filter :require_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
    @user = User.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    @user = User.new

    if @user_session.save
      redirect_to admin_root_path
    else
      flash[:error] = "Please enter a valid email and password combination."
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to admin_root_path
  end
end