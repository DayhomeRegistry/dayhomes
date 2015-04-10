class Admin::UsersController < Admin::ApplicationController
  helper_method :sort_column, :sort_direction
  def index
    @users = User.page(params[:page] || 1).per(params[:per_page] || 10)
    sort = sort_column
    if (sort== 'full_name')
      sort = 'last_name,first_name'
    end

    if (!params[:query].nil?)
      clause = params[:query]      
       
      
      if (!clause.empty?)
        @users = User.where("concat(first_name,' ',last_name) like ?", "%#{clause.strip}%")
      else
        @users = User.all
      end
      #return render :text=> clause.strip+"|"+feature+"|"+approve
      
      @users = @users.order(sort + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10)
      @query = params[:query]
    else 

      @users = User.order(sort + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10)
    end    
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
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
    @user.assign_attributes(user_params)  
    
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
  def user_params
    params.require(:user).permit(
        :email, :password, :password_confirmation, :remember_me, :first_name,:last_name, :provider, :uid, :admin, 
        :assign_day_home_ids, :location_id)
  end
end
