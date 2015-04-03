class DayHomesController < ApplicationController

  before_filter :require_user, :except => [:show, :contact, :calendar, :followup]
  before_filter :require_user_to_be_organization_admin, :except => [:show, :contact, :calendar, :followup]
  helper_method :sort_column, :sort_direction
    
  def index
    if (!params[:query].nil?)
      clause = params[:query]      
      result = clause.scan(/(\bfeatured:\b[^\s]*)/)            
      feature = result.length==0 ? "" : result[0][0]
      result = clause.scan(/(\bapproved:\b[^\s]*)/)
      approve = result.length==0 ? "" : result[0][0] 
      result = clause.scan(/(\blocation:\b[^\s]*)/)
      location = result.length==0 ? "" : result[0][0]   
      clause = clause.gsub(feature,"")
      clause = clause.gsub(approve,"")            
      clause = clause.gsub(location,"")  
      location = location.gsub("location:","")

      
      if (current_user.organization_admin?)
        if (!clause.empty?)
          @day_homes = current_user.organization.day_homes.where("day_homes.name like ?", "%#{clause.strip}%") 
        else
          @day_homes = current_user.organization.day_homes
        end
      else 
        if (!clause.empty?)
          @day_homes = current_user.day_homes.where("day_homes.name like ?", "%#{clause.strip}%")
        else
          @day_homes = current_user.day_homes
        end
      end
      #return render :text=> clause.strip+"|"+feature+"|"+approve

      
      if(!location.empty?)
        #raise @day_homes.where("locations.name like '%#{location}%'").to_json
        @day_homes = @day_homes.where("locations.name like '%#{location}%'")
      end

      if(!feature.empty?)            
        @day_homes = @day_homes.where(:featured=> feature=="featured:yes")
      end
      if(!approve.empty?)
        @day_homes = @day_homes.where(:approved=> approve=="approved:yes")
                
      end
      @day_homes = @day_homes.order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10)
      @query = params[:query]
    else 
      
      if (current_user.organization_admin?)      
        @day_homes = current_user.organization.day_homes.order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10)      
      else
        @day_homes = current_user.day_homes.order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10)      
      end
    end
  end
  def deleted
    if (!params[:query].nil?)
      clause = params[:query]      
      result = clause.scan(/(\bfeatured:\b[^\s]*)/)            
      feature = result.length==0 ? "" : result[0][0]
      result = clause.scan(/(\bapproved:\b[^\s]*)/)
      approve = result.length==0 ? "" : result[0][0] 
      result = clause.scan(/(\blocation:\b[^\s]*)/)
      location = result.length==0 ? "" : result[0][0]   
      clause = clause.gsub(feature,"")
      clause = clause.gsub(approve,"")            
      clause = clause.gsub(location,"")  
      location = location.gsub("location:","")

      
      if (current_user.organization_admin?)
        @day_homes = DayHome.unscoped.where("deleted=1 and location_id in (?)",current_user.organization.locations.map(&:id))
        if (!clause.empty?)
          @day_homes = @day_homes.where("day_homes.name like ?", "%#{clause.strip}%") 
        end
      else
        @day_homes = DayHome.unscoped.where("deleted=1 and location_id in (?)",current_user.organization.locations.map(&:id))
        if (!clause.empty?)          
          @day_homes = @day_homes.where("day_homes.name like ?", "%#{clause.strip}%")
        end
      end
      #return render :text=> clause.strip+"|"+feature+"|"+approve

      
      if(!location.empty?)
        #raise @day_homes.where("locations.name like '%#{location}%'").to_json
        @day_homes = @day_homes.where("locations.name like '%#{location}%'")
      end

      if(!feature.empty?)            
        @day_homes = @day_homes.where(:featured=> feature=="featured:yes")
      end
      if(!approve.empty?)
        @day_homes = @day_homes.where(:approved=> approve=="approved:yes")
                
      end
      @day_homes = @day_homes.order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10)
      @query = params[:query]
    else 
      @day_homes = DayHome.unscoped.where("deleted=1 and location_id in (?)",current_user.organization.locations.map(&:id))
      @day_homes = @day_homes.order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10)      
    end
  end

  
  def show
    @day_home = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:id])

    if @day_home.nil?
      redirect_to '/404.html', :status => 301
    else
      @review = Review.new
      @reviews = @day_home.reviews.page(params[:page]).per(5)

      # simple email protection from spammers
      @day_home_contact = DayHomeContact.new()
      @day_home_contact.day_home_email = Base64::encode64(@day_home.email)
      
    end
  end

  def contact
  
    params[:day_home_contact][:day_home_email] = Base64::decode64(params[:day_home_contact][:day_home_email])
    @day_home = DayHome.find(params[:id])
    byebug

    @day_home_contact = DayHomeContact.new(day_home_contact_params)
    @day_home_contact.day_home_id = @day_home.id        

    if validate_recap(params, @day_home_contact.errors) && @day_home_contact.save
      #redirect_to day_home_slug_path(@day_home.slug), :notice => "#{@day_home.name} has been contacted!"

      redirect_to followup_day_home_path(@day_home)
    else
      flash[:danger]= "Something went wrong while sending your message - please try again: "+@day_home_contact.errors.full_messages.to_sentence
      redirect_to day_home_slug_path(@day_home.slug)
    end
  end

  def calendar
    @dayhome = DayHome.find(params[:id])
    @event = Event.new

    # check if a user is logged in
    if current_user
      # check if the user has a dayhome that's related with this id
      @day_home_admin = false
      current_user.day_homes.each do |day_home|
        if day_home.id == @dayhome.id
          # the user is related to the dayhome, admin found!
          @day_home_admin = true
          break
        else
          @day_home_admin = false
        end
      end
    else
      # no logged in user
      @day_home_admin = false
    end
  end


  def edit
    if(current_user.organization_admin?)
      @day_home = current_user.organization.day_homes.find(params[:id])
    else
      @day_home = current_user.day_homes.find(params[:id])
    end
    @day_home.photos.build
  end
  
  def update
    byebug
    #the empty hash we "build" in edit breaks the validation
    if(!params[:day_home][:photos_attributes].nil?)
      params[:day_home][:photos_attributes].each do |k,v|
        if (v["_destroy"]!="1" && v["photo"].nil?)
          params[:day_home][:photos_attributes].except!(k)
        end
      end
    end

    if(current_user.organization_admin?)
      @day_home = current_user.organization.day_homes.find(params[:id])
    else
      @day_home = current_user.day_homes.find(params[:id])
    end
    
    if @day_home.update_attributes(day_home_params)
      redirect_to day_homes_path
    else
      render :action => :edit
    end
  end
  def followup  
    @day_home = DayHome.find(params[:id])
  end  
  def new
    #you can't create one if you're at your limit
    organization = current_user.organization
    plan = Plan.find_by_plan(organization.plan)
    

    if(plan.day_homes > 0 && plan.day_homes <= organization.day_homes.count())
      flash[:error]="Sorry, you've reached your day home limit."
      return redirect_to :action=>:index
    end

    @day_home = DayHome.new
    @day_home.organization=organization
    @day_home.email = organization.billing_email
    @day_home.photos.build
  end


  def create
    @day_home = DayHome.new(day_home_params)
    @day_home.approved = true
    
    if @day_home.save
      redirect_to day_homes_path
    else
      render :action => :new
    end
  end
  def destroy
    @day_home = DayHome.find(params[:id])
    @day_home.deleted = true;
    @day_home.deleted_on = DateTime.now();
    if @day_home.save
      flash[:success] = "#{@day_home.name} has been deleted. Check the deleted tab below to reactivate."
    else
      flash[:error] = "Unable to remove #{@day_home.name}"
    end

    redirect_to day_homes_path
  end
  def reactivate
    organization = current_user.organization
    plan = Plan.find_by_plan(organization.plan)
    

    max_dayhomes = plan.day_homes
    if(plan.day_homes > 0 && max_dayhomes <= organization.day_homes.count())
      flash[:error]="Sorry, you've reached your day home limit."
    else
      @day_home = DayHome.deleted.find(params[:day_home_id])
      @day_home.deleted = false;
      @day_home.deleted_on = nil;
      if @day_home.save
        flash[:success] = "#{@day_home.name} reactivated."
      else
        flash[:error] = "Something went wrong trying to reactivate #{@day_home.name}."
      end
    end

    redirect_to deleted_day_homes_path(:params=>params)

  end
  
  private
  def sort_column
    DayHome.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"    
  end 

  def day_home_params
    params.require(:day_home).permit(:name, :approved, :featured, :slug, :phone_number, :email, :highlight, :blurb, 
                  :street1, :street2, :postal_code, :city, :province, :photos_attributes, :dietary_accommodations, 
                  :licensed, :location_id, :caption, :default_photo, :photo, :featured_end_date, 
                  availability_type_ids: [], 
                  certification_type_ids: [], 
                  photos_attributes: [:caption, :default_photo, :photo, "_destroy", :id])
  end
  def day_home_contact_params
    params.require(:day_home_contact).permit(:name,:email,:phone,:home_address,:child_start_date,:child_name,:child_birth_date,:child_name2,:child_birth_date2,:subject,:message,:day_home_email,:day_home_id)
  end
end

