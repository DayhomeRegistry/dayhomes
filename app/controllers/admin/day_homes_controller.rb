class Admin::DayHomesController < Admin::ApplicationController
  def index
    sort = params[:sort].nil? ? "name" : params[:sort]
    direction = params[:direction].nil? ? "asc" : params[:direction]
    @day_homes = DayHome.order(sort + ' ' + direction).page(params[:page] || 1).per(params[:per_page] || 10)
  end

  def show
    @day_home = DayHome.find(params[:id])
  end

  def new
    @day_home = DayHome.new
    @day_home.photos.build
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
    @day_home.photos.build if @day_home.photos.blank?
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
  
  def mass_update      
    text = "<div>The following dayhomes were "
    function = params[:day_home]["mass_function"]
    text += function + "d:<ul>"
    if params[:select]
      case function
        when "approve"
          params[:select].each do |dayhome|
            @day_home = DayHome.find_by_slug(dayhome)
            if(!@day_home.approved)
              text += "<li>"+@day_home.name+"</li>"
              @day_home.approved = true
              @day_home.save
            end
          end
        when "feature"
          params[:select].each do |dayhome|
            @day_home = DayHome.find_by_slug(dayhome)
            if(!@day_home.featured)
              text += "<li>"+@day_home.name+"</li>"
              @day_home.featured = true
              @day_home.save
            end
          end
      end
      text += "</ul></div>"
    end
    #return render :text => text
    flash[:success] = text
    redirect_to :action => :index
  end
  
end
