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
          format.json {return render :json => {:success => false, :error=>(e.message||e.to_json)}}
          
        end
      
      
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

  # AJAX posts
  #   Overview
  def setTitle
    @dayhome = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:dayhome_id])
    @dayhome.name=params[:title];

    @dayhome.save
    ajax_response("Title",@dayhome,request.format)
  end
  def setSummary
    @dayhome = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:dayhome_id])
    @dayhome.highlight=params[:summary];

    @dayhome.save
    ajax_response("Summary",@dayhome,request.format)
  end
  def setDescription
    @dayhome = DayHome.find_by_slug(params[:slug]) || DayHome.find_by_id(params[:dayhome_id])
    @dayhome.blurb=params[:description];

    @dayhome.save
    ajax_response("Description",@dayhome,request.format)
  end
  #   Photos


  private
  def ajax_response(field_name, resource, format) 
    if(resource.errors.full_messages.length>0)
      respond_to do |format|
        format.html {raise "setTitle is AJAX only"}
        format.js {
          return render :json => {:success => false, :errors => "Error saving " + field_name + ": " + resource.errors.full_messages.join(', ')}
        }
      end
    else 
      respond_to do |format| 
        format.html {raise "setTitle is AJAX only"}
        format.js {
          return render :json => {:success => true}
        }
      end
    end
  end
  def sort_column
    DayHome.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"    
  end  
end
