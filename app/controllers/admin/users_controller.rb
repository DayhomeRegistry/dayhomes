class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to admin_users_path
    else
      render :action => :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to admin_users_path
    else
      render :action => :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    unless @user.destroy
      flash[:error] = "Unable to remove #{@user.full_name}"
    end

    redirect_to admin_users_path
  end
  
end
