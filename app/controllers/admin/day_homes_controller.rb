class Admin::DayHomesController < Admin::ApplicationController
  def index
    @day_homes = DayHome.all
  end

  def show
    @day_home = DayHome.find(params[:id])
  end

  def new
    @day_home = DayHome.new
  end

  def create
    @day_home = DayHome.new(params[:day_home])
    
    if @day_home.save
      redirect_to admin_day_homes_path
    else
      render :action => :new
    end
  end

  def edit
    @day_home = DayHome.find(params[:id])
  end

  def update
    @day_home = DayHome.find(params[:id])

    if @day_home.update_attributes(params[:day_home])
      redirect_to admin_day_homes_path
    else
      render :action => :edit
    end
  end

  def destroy
    @day_home = DayHome.find(params[:id])
    unless @day_home.destroy
      flash[:error] = "Unable to remove #{@day_home.name}"
    end

    redirect_to admin_day_homes_path
  end
  
end
