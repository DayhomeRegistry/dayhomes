class DayhomesController < ApplicationController
  layout 'beta'
  before_filter :authenticate_user!
  helper_method :sort_column, :sort_direction

  # Views
  def index
    byebug
  	@dayhomes = current_user.organization.day_homes.order(sort_column + ' ' + sort_direction).page(params[:page] || 1).per(params[:per_page] || 5)
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
    @dayhome = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:dayhome_id])

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

  private
  def ajax_response(field_name, resource, format) 
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
          return render :json => {:success => true}
        }
      end
    end
  end
  def ajax_rescue(e) 
    byebug
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
