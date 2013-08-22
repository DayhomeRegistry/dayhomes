class Admin::DayHomesController < Admin::ApplicationController
  helper_method :sort_column, :sort_direction
  def index    
    #return render :text=>url_for({:sort => "name", :direction => "asc"})
    if (!params[:query].nil?)
      clause = params[:query]      
      result = clause.scan(/(\bfeatured:\b[^\s]*)/)            
      feature = result.length==0 ? "" : result[0][0]
      result = clause.scan(/(\bapproved:\b[^\s]*)/)
      approve = result.length==0 ? "" : result[0][0]  
      clause = clause.gsub(feature,"")
      clause = clause.gsub(approve,"")            
      
      if (!clause.empty?)
        @day_homes = DayHome.includes(:photos).where("name like ?", "%#{clause.strip}%")
      else
        @day_homes = DayHome.includes(:photos).scoped
      end
      #return render :text=> clause.strip+"|"+feature+"|"+approve
      
      if(!feature.empty?)            
        @day_homes = @day_homes.where(:featured=> feature=="featured:yes")
      end
      if(!approve.empty?)
        @day_homes = @day_homes.where(:approved=> approve=="approved:yes")
                
      end
      @day_homes = @day_homes.order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10)
      @query = params[:query]
    else 
      @day_homes = DayHome.includes(:photos).order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10)
    end
    
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

    #raise @day_home.organization.to_json
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
  
  private
  def sort_column
    DayHome.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"    
  end  
end
