class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :require_no_user, :only => [:new, :create], :unless => :organization_user
  before_filter :require_user, :only => [:show, :update, :index]
  before_filter :require_user_to_be_organization_admin, :only=>[:index]
  
  def show
    @user = current_user
  end

  def new
    @user = User.new
    if (!current_user.nil?)
      #you can't create one if you're at your limit
      organization = current_user.organization
      plan = Plan.find_by_plan(organization.plan)
  #raise plan.staff.to_s
  #raise organization.users.count().to_s
      if(plan.staff <= (organization.users.count()-1))
        flash[:error]="Sorry, you've reached your staff limit. Adding a user for a fee is coming soon."
        return redirect_to :action=>:index
      end


      @user.organization = organization
    end
  end

  def create
    @user = User.new(user_params)
    if(!current_user.nil?)
      organization = current_user.organization
      @user.organization = organization
    end
    if @user.save
      if(!current_user.nil? && current_user.organization_admin?)
        current_user.organization.users<<@user;
        current_user.organization.save
        redirect_to users_path
      else
        redirect_to root_path
        flash[:success] = "Thanks for signing up #{@user.full_name}!"
      end
    else
      render :action => :new
    end
  end

  def edit
    @user = current_user
    if (@user.organization_admin? && !params[:id].nil?)
      @user = User.find(params[:id])
    end
    
  end

  def update
    @user = User.find(params[:id])
    params = user_params
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    @user.assign_attributes(params) 
    if @user.save
      redirect_to users_path()
    else
      return render :action => :edit
    end
  end

  def index
    #this is just for org admin to edit the users associated with the org
    @users = current_user.organization.users.page(params[:page] || 1).per(params[:per_page] || 10)
  end

  def destroy
    @user = User.find(params[:id])
    unless @user.destroy
      flash[:error] = "Unable to remove #{@user.full_name}"
    else
      flash[:success] = "#{@user.full_name} has been removed."
    end

    redirect_to users_path
  end
  
  def send_reset_password_instructions
    user = User.find(params[:user_id])
    user.send_reset_password_instructions
    flash[:notice] = "Reset password instructions have been sent to #{user.email}."
    redirect_to users_path
  end
    
  private
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "full_name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"    
  end  

  def organization_user
    return !current_user.nil? && current_user.organization_admin?
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :remember_me, :first_name,:last_name, :provider, :uid, :admin, :assign_day_home_ids, :location_id)
  end
end