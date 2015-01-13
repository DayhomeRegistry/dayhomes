class DayhomesController < ApplicationController
  layout 'beta'
  before_filter :authenticate_user!
  helper_method :sort_column, :sort_direction

  # before_filter :check_for_plan

  def check_for_plan
    if current_user && current_user.organization && current_user.organization.plan.empty?
      byebug
      redirect_to({ controller: 'beta', action: 'plan' })
    end
  end
  # Views
  def index
    @dayhomes
    if(current_user.admin?)
      @dayhomes= DayHome.all
    else
      if(current_user.organization_admin?)
        @dayhomes = current_user.organization.day_homes
      else
        @dayhomes = current_user.day_homes
      end
    end
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

      if (!clause.empty?)
        @dayhomes = @dayhomes.where("day_homes.name like ?", "%#{clause.strip}%")
      end
      
      if(!location.empty?)
        @dayhomes = @dayhomes.where("locations.name like '%#{location}%'")
      end

      if(!feature.empty?)            
        @dayhomes = @dayhomes.where(:featured=> feature=="featured:yes")
      end

      if(!approve.empty?)
        @dayhomes = @dayhomes.where(:approved=> approve=="approved:yes")
      end

      @query = params[:query]
    end
    @dayhomes = @dayhomes.order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 5)
  end
  
  def create
    begin
      byebug
    #Find or create the community
      createdCommunity=false
      city,province,country = params["dayhome"]["city"].split(/,/)
      community = Community.find_by(name: city);
      if (community.nil?)
          community = Community.new()
          community.name=city
          if(!community.save)
            community = Community.all().first();
          else
            createdCommunity=true
          end
        end

      #Create the location

        loc = Location.new()
        loc.name = city
        loc.community=community
        loc.save!  #this will throw
        
        current_user.location = loc;
        current_user.save! #this will throw

      #Create the dayhome
        @day_home = DayHome.new()
        @day_home.email = current_user.email
        @day_home.location = loc
        @day_home.name = params["dayhome"]["title"]
        @day_home.slug = @day_home.name.gsub(/\W/,'').downcase
  
        #add default availability
        #full_time_full_days = AvailabilityType.where({:availability => 'Full-time', :kind => 'Full Days'}).first
        #@day_home.availability_types << full_time_full_days

        @day_home.save! #this will throw

      #Create the org
      
        if(current_user.organization.nil?)
          org = Organization.new()
          org.city = city
          org.province = province || 'Alberta'        
          org.billing_email = current_user.email
          org.users << current_user
          org.save! #this will throw
        end

        #Now tidy up the links
        loc.organization = org
        loc.save! #this will throw
        byebug
    #Redirect to show
      if @day_home.save
        respond_to do |format|
          format.html {return redirect_to beta_dayhome_overview_path(@day_home)}
          format.json {return render :json => {:success => true, :url=>beta_dayhome_overview_path(@day_home)}}
        end
      else
        respond_to do |format|
          format.html {return render :action => :new}
          format.json {return render :json => {:success => false, :error=>@day_home.errors.to_json}}
        end
      end
    rescue => e
      ajax_rescue(e)
    end
  end

  def show
    @dayhome = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:dayhome_id])
    
  end

  # Dayhome actions from single layout
  def overview
    @dayhome = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:dayhome_id])

    render "dayhome"
  end
  def photos
    @dayhome = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:dayhome_id])

    render "dayhome"
  end
  def location
    byebug
    @dayhome = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:dayhome_id])
    if(@dayhome.nil?)
      @dayhome = DayHome.all.first
    end
    render "dayhome"
  end
  def certifications
    @dayhome = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:dayhome_id])

    render "dayhome"
  end
  def spots
    @dayhome = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:dayhome_id])

    render "dayhome"
  end
  def plan
    @dayhome = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:dayhome_id])
    @organization = current_user.organization
    @packages = {}
    @communities = Community.all
    Plan.where("inactive is null").where(@organization.individual? ? "org_type = 'individual'" : "org_type = 'group'").order(:monthly_price).each do |p|
      @packages.merge!({"#{p.id}" => p}) #unless p===@existing
    end
    render "dayhome"
  end
  # AJAX posts
  #   Overview
  def setTitle
    @dayhome = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:dayhome_id])
    @dayhome.name=params[:title];

    @dayhome.save
    ajax_response("saving title",@dayhome,request.format)
  end
  def setSummary
    @dayhome = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:dayhome_id])
    @dayhome.highlight=params[:summary];

    @dayhome.save
    ajax_response("saving summary",@dayhome,request.format)
  end
  def setDescription
    @dayhome = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:dayhome_id])
    @dayhome.blurb=params[:description];

    @dayhome.save
    ajax_response("saving description",@dayhome,request.format)
  end
  #   Photos
  #   POST - format.html
  def addPhoto
    
    begin
      @dayhome = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:dayhome_id])
      if params[:image].try(:original_filename) == 'blob'
        params[:image].original_filename << '.png'
      end
      data = params[:image]
      #image      = Base64.decode64(data[data.index('base64,')+7 .. -1])
      @photo = DayHomePhoto.new()
      @photo.day_home = @dayhome
      @photo.photo = data
      if(@photo.save)
        @dayhome.photos << @photo
        @dayhome.save

        # Since this one is an HTML post (for the file), we can't use ajax_response
        template = render_to_string partial: "photo"
        return render :json => {:success=>true, :template => template.to_s}
      else
        head :bad_request
      end
    rescue => e
      byebug
      if(resource.errors.full_messages.length>0)
        render plain: "Error " + field_name + ": " + resource.errors.full_messages.join(', '), status: bad_request
      else
        render plain: e.to_s, status: bad_request
      end
    end
  end
  def removePhoto
    photo = DayHomePhoto.find_by(id: params[:id])
    if(photo.destroy)
      head :ok
    else 
      render plain: "Couldn't delete photo", status: bad_request
    end
  end
  def setDefaultPhoto
    dayhome = DayHome.find_by(id: params[:dayhome_id])
    dayhome.photos.each do |photo|
      photo.default_photo=false;
      photo.save
    end
    photo = DayHomePhoto.find_by(id: params[:photo_id])
    photo.default_photo = true

    if(photo.save)
      head :ok
    else 
      render plain: "Couldn't set default photo", status: bad_request
    end
  end
  def setCaption
    photo = DayHomePhoto.find_by(id: params[:photo_id])
    photo.caption = params[:caption]

    photo.save
    ajax_response("saving description",photo,request.format)
  end
  def setAddress
    dayhome = DayHome.find_by(id: params[:dayhome_id])
    address = params[:form][:day_home]
    dayhome.street1 = address[:street1]
    dayhome.street2 = address[:street2]
    dayhome.city = address[:city]
    dayhome.province = address[:province]
    dayhome.postal_code = address[:postal_code]
    dayhome.save

    # TODO
    # Need to add a spree customer address!

    ajax_response("saving address",dayhome,request.format, {lat: dayhome.lat, lng:dayhome.lng})
  end
  def setCertifications
    dayhome = DayHome.find_by(id: params[:dayhome_id])
    form_params = params[:form]
    dayhome.update_attributes(form_params[:day_home].permit(:assign_certification_type_ids))
    dayhome.save
    ajax_response("saving certifications",dayhome,request.format, {})
  end

  private
  def ajax_response(field_name, resource, format, data=[]) 
    #byebug
    if(resource.errors.full_messages.length>0)
      respond_to do |format|
        format.html {raise "AJAX only! "+"Error " + field_name + ": " + resource.errors.full_messages.join(', ')}
        format.js {
          return render :json => {:success => false, :errors => "Error " + field_name + ": " + resource.errors.full_messages.join(', ')}
        }
      end
    else 
      respond_to do |format| 
        format.html {raise "AJAX only! "}
        format.js {
          return render :json => {:success => true, :data=>data}
        }
      end
    end
  end
  def ajax_rescue(e) 
    respond_to do |format|
        format.html {
          if(!e.message.nil?)
            flash.now['error'] = e.message
            logger.error e.message
          else
            flash.now['error'] = e
            logger.error e
          end
          redirect_to "beta/list"
        }
        format.json {return render :json => {:success => false, :errors=>(e.message||e.to_json)}}    
    end
  end
  def sort_column
    DayHome.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"    
  end  
end
