class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :update]
  
  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to root_path
      flash[:notice] = "Thanks for signing up #{@user.full_name}!"
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    if current_user.update_attributes(params[:user])
      redirect_to user_path(current_user)
    else
      render :action => :edit
    end
  end

end
