class Admin::UsersController < Admin::ApplicationController
  helper_method :sort_column, :sort_direction
  def index
    @users = User.page(params[:page] || 1).per(params[:per_page] || 10)
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
    @user.assign_attributes(params[:user])  
    
    if @user.save
      redirect_to    admin_users_path
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
  
    
  private
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "full_name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"    
  end  
end
