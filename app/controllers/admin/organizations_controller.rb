class Admin::OrganizationsController < Admin::ApplicationController
  helper_method :sort_column, :sort_direction
  def index    
    #raise params[:query].to_s
    #return render :text=>url_for({:sort => "name", :direction => "asc"})
    if (!params[:query].nil?)
      clause = params[:query]      
      
      
      if (!clause.empty?)
        @organizations = Organization.where("name like ?", "%#{clause.strip}%")
      else
        @organizations = Organization.all
      end
      
      @organizations = @organizations.order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10)
      @query = params[:query]
    else 
      @organizations = Organization.order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10)
    end
    
  end

  def show
    @organization = Organization.find(params[:id])
    @plan = Plan.find_by_plan(@organization.plan)
    @day_homes = @organization.day_homes.order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10)
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    
    if @organization.save
      redirect_to admin_organizations_path
    else
      render :action => :new
    end
  end

  def edit
    @organization = Organization.find(params[:id])

  end

  def update
    @organization = Organization.find(params[:id])    
    @organization.update_attributes(organization_params)  
    if @organization.save 
      redirect_to admin_organizations_path
    else
      render :action => :edit
    end
  end

  def destroy
    #raise params[:id].to_s
    @organization = Organization.find_by_id(params[:id])
    unless @organization.destroy
      flash[:error] = "Unable to remove #{@organization.name}: "+@organization.errors[:base][0].to_s
    end

    redirect_to admin_organizations_path
  end
  def mass_update   
  #{"action":"show","controller":"admin/organizations","id":"8"}
  #{"day_home":{"mass_function":"approve"},"id":{"8":""},"select":{"aliciasdayhome":"aliciasdayhome","amysdayhome":"amysdayhome"},"controller":"admin/organizations","action":"mass_update"}
    @organization = Organization.find(params[:id])
    @organization.to_json
    text = "<div>The following dayhomes were "
    function = params[:day_home]["mass_function"]
    text += function + "d:<ul>"
    if params[:select]
      case function
        when "approve"
          params[:select].each do |dayhome|
            day_home = DayHome.find_by_slug(dayhome)
            text += "<li>"+day_home.name+"</li>"
            day_home.approved = !day_home.approved
            day_home.save
          end
        when "feature"
          params[:select].each do |dayhome|
            day_home = DayHome.find_by_slug(dayhome)
            text += "<li>"+day_home.name+"</li>"
            day_home.featured = !day_home.featured
            day_home.save            
          end
      end
      text += "</ul></div>"
    end
    #return render :text => text
    flash[:success] = text
    redirect_to admin_organization_path(@organization)
  end
    
  private
  def sort_column
    Organization.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"    
  end  
  def organization_params
    params.require(:organization).permit(
              :name, :phone_number, :street1, :street2, :city, :billing_email,
              :province, :postal_code, :blurb, :stripe_card_token,
              logo_attributes:[:photo],
              pin_attributes:[:photo])
  end
end
