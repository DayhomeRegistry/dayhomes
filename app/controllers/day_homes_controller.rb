class DayHomesController < ApplicationController
  before_filter :require_user, :except => :show
  before_filter :require_user_to_be_day_home_owner, :except => :show
    
  def index
    @day_homes = current_user.day_homes
  end
  
  def show
    @day_home = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:id])

    if @day_home.nil?
      redirect_to '/404.html', :status => 301
    else
      @review = Review.new
      @reviews = @day_home.reviews.page(params[:page]).per(5)
    end
  end
  
  def edit
    @day_home = current_user.day_homes.find(params[:id])
  end
  
  def update
    @day_home = current_user.day_homes.find(params[:id])
    
    if @day_home.update_attributes(params[:day_home])
      redirect_to day_homes_path
    else
      render :action => :edit
    end
  end
  
  private
  
  def require_user_to_be_day_home_owner
    unless current_user.day_home_owner?
      redirect_to root_path
    end
  end
end