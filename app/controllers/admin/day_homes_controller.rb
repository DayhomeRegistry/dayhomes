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
        @day_homes = DayHome.includes(:photos).all
      end
      #return render :text=> clause.strip+"|"+feature+"|"+approve
      
      if(!feature.empty? && feature=="featured:yes")  
        @day_homes = @day_homes.featured
      end
      if(!approve.empty?)
        @day_homes = @day_homes.where(:approved=> approve=="approved:yes")
                
      end
      @day_homes = @day_homes.order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10)
      @query = params[:query]
    else 
      @day_homes = DayHome.order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10)
    end    
  end
  def deleted
    if (!params[:query].nil?)
      clause = params[:query]      
      result = clause.scan(/(\bfeatured:\b[^\s]*)/)            
      feature = result.length==0 ? "" : result[0][0]
      result = clause.scan(/(\bapproved:\b[^\s]*)/)
      approve = result.length==0 ? "" : result[0][0]  
      clause = clause.gsub(feature,"")
      clause = clause.gsub(approve,"")            
      
      if (!clause.empty?)
        @day_homes = DayHome.deleted.where("name like ?", "%#{clause.strip}%")
      else
        @day_homes = DayHome.deleted
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
      @day_homes = DayHome.deleted.order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10)
    end    

  end

  def show
    @day_home = DayHome.find(params[:id])
  end

  def new
    @day_home = DayHome.new
    @day_home.photos.build

    @communities = Community.all
  end

  def create
    #the empty hash we "build" breaks the validation
    if(!params[:day_home][:photos_attributes].nil?)
      params[:day_home][:photos_attributes].each do |k,v|
        if (v["_destroy"]!="1" && v["photo"].nil?)
          params[:day_home][:photos_attributes].except!(k)
        end
      end
    end

    @error_msg = []

    @communities = Community.all

    DayHome.transaction do
      @day_home = DayHome.new(day_home_params)
        
      #raise @day_home.to_json
      #Create the user
        user = User.find_by_email(@day_home.email)      
        if(!user.nil?)
          flash.now['page-danger'] = "Looks as though this person (#{@day_home.email}) is already registered."
          raise 'User already present'
          #return render :action => :new
        end
        #no one here, create a new one
        user = User.new_from_signup_request(OpenStruct.new({:first_name=>"",:last_name=>"",:contact_email=>@day_home.email}))

        if(!user.save)
          user.errors.full_messages.each do |err|
            @error_msg << err+" (user)"
          end
          flash.now['page-danger'] = @error_msg.join("<br/>").html_safe
          raise "User save error"
          #return render :action => :new 
        end



      #Create the org    
        org = Organization.new()
        #org.stripe_coupon_code = @coupon.nil? ? nil : @coupon.id
        org.name = @day_home.name
        org.city = @day_home.city
        org.province = @day_home.province
        org.street1 = @day_home.street1
        org.postal_code = @day_home.postal_code
        org.billing_email = @day_home.email
        #org.phone_number = @day_home.contact_phone_number
        org.users << user

        #if request.env['affiliate.tag'] && affiliate = Organization.find_by_affiliate_tag(request.env['affiliate.tag'])
        #  org.mentor = affiliate
        #end

        #if(@day_home.plan!="baby") 
        #  org.stripe_card_token = @day_home.stripe_card_token
        #  org.plan = @day_home.plan
        #  if !org.save_with_payment 
        #    handle_org_error(org)
        #  end
        #else
          if(!org.save)
            org.errors.full_messages.each do |err|
              @error_msg << err+" (org)"
            end
            flash.now['page-danger'] = @error_msg.join("<br/>").html_safe
            raise "Org save error"
            #return render :action => :new 
          end
        #end

      #Create the location
        loc = Location.new()
        loc.community_id=params[:location][:community_id]
        loc.name = Community.find(loc.community_id) || @day_home.city || 'Edmonton'
        loc.organization = org

        if(!loc.save)
          loc.errors.full_messages.each do |err|
            @error_msg << err+" (location)"
          end
          flash.now['page-danger'] = @error_msg.join("<br/>").html_safe
          raise "Loc save error"
          #return render :action => :new 
        end
        user.location = loc;
        if(!user.save)
          user.errors.full_messages.each do |err|
            @error_msg << err+" (user)"
          end
          flash.now['page-danger'] = @error_msg.join("<br/>").html_safe
          raise "User save error"
          #return render :action => :new 
        end           

      #Create the dayhome
        
        @day_home.location = loc

        #add default availability
        # full_time_full_days = AvailabilityType.where({:availability => 'Full-time', :kind => 'Full Days'}).first
        # @day_home.availability_types << full_time_full_days

        if(!@day_home.save)
          @day_home.errors.full_messages.each do |err|
            @error_msg << err+" (dayhome)"
          end
          flash.now['page-danger'] = @error_msg.join("<br/>").html_safe
          raise "Dayhome save error"
          #return render :action => :new 
        end


      if @day_home.save
        #email them their password set instructions
        #UserMailer.new_user_password_instructions(user).deliver 
        user.send_confirmation_instructions

        redirect_to admin_day_homes_path
      else
        render :action => :new
      end
    end
  rescue
    render :action => :new
  end



  def edit
    @day_home = DayHome.find(params[:id])
    @day_home.photos.build if @day_home.photos.blank?
    @communities = Community.all

    #raise @day_home.organization.to_json
    render :params=>{:page=>params["page"]}
  end

  def update
   
    community = Community.find(params[:location][:community_id]) 

    #raise community.to_json
    #the empty hash we "build" in edit breaks the validation
    params[:day_home][:photos_attributes].each do |k,v|
      if (v["_destroy"]!="1" && v["photo"].nil?)
        params[:day_home][:photos_attributes].except!(k)
      end
    end
    
    @day_home = DayHome.find(params[:id]) 
    featured = true   
    if params[:day_home][:featured].nil? || params[:day_home][:featured]=="0"
      #the checkbox is not checked
      if @day_home.featured?
        @day_home.featured=false
      end
      featured = false
    end
    if(featured && !@day_home.featured?)
      untilDate = Date.strptime(params[:day_home][:featured_end_date], "%m/%d/%Y") #Date.parse(params[:day_home][:feature_end_date])
      #months = [(untilDate.year * 12 + untilDate.month) - (Date.today.year * 12 + Date.today.month-1),1].max
      @day_home.activate_admin_until(untilDate)
    end

    if @day_home.update_attributes(day_home_params.except(:featured_end_date))
      @day_home.location.community_id=community.id
      @day_home.location.save
      redirect_to admin_day_homes_path(:page=>(params["page"].kind_of?(Array) ? 1 : params["page"].keys[0]))
    else

      render :action => :edit
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

    redirect_to admin_day_homes_path(:params=>params)
  end
  def reactivate
    @day_home = DayHome.deleted.find(params[:day_home_id])
    @day_home.deleted = false;
    @day_home.deleted_on = nil;
    if @day_home.save
      flash[:success] = "#{@day_home.name} reactivated."
    else
      flash[:error] = "Something went wrong trying to reactivate #{@day_home.name}."
    end
    redirect_to admin_deleted_day_homes_path(:params=>params)

  end
  def obliterate
    @day_home = DayHome.deleted.find(params[:day_home_id])
    if @day_home.destroy
      flash[:success] = "#{@day_home.name} has been deleted forever. May it rest in peace."
    else
      flash[:error] = "Unable to obliterate #{@day_home.name}"
    end

    redirect_to admin_deleted_day_homes_path(:params=>params)
  end
  
  def mass_update      
    text = "<div>The following dayhomes were "
    error = "<div>The following dayhomes had issues being "
    show_error=false
    show_success=false
    function = params[:day_home]["mass_function"]
    text += function + "d:<ul>"
    error += function + "d:<ul>"
    if params[:select]
      case function
        when "approve"
          params[:select].each do |dayhome|
            @day_home = DayHome.find_by_slug(dayhome)
            if(!@day_home.approved)
              text += "<li>"+@day_home.name+"</li>"
              @day_home.approved = true
              @day_home.save
              show_success=true
            end
          end
        when "feature"
          params[:select].each do |dayhome|
            @day_home = DayHome.find_by_slug(dayhome)
            if(!@day_home.featured?)
              @day_home.admin_featured=true
              text += "<li>"+@day_home.name+"</li>"
              show_success=true
            else
              show_error=true
              error +="<li>"+@day_home.name+": already featured this month.</li>"
            end
          end
      end
      text += "</ul></div>"
      error += "</ul></div>"
    end
    #return render :text => text
    if(show_success)
      flash[:success] = text
    end
    if(show_error)
      flash[:error] = error
    end
    
    redirect_to :action => :index, :params=>{:page=>params["page"].keys[0]}
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
                  photos_attributes: [:caption, :default_photo, :photo])
  end
end
