class BetaController < ApplicationController
	#layout "application", only: [:list]
	
  # Redirect default
  def index
    redirect_to beta_list_path()
  end
	# Landing page
	def list
    @disable_subnav=true
	end

  def dashboard
  end

	def new
		@params = params
	end
	# From the beta landing page
	# Params =>
	#     dayhome[care_type_id]
	#     dayhome[capacity]
	#     dayhome[city]
	def create
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
  
        #add default availability
        full_time_full_days = AvailabilityType.where({:availability => 'Full-time', :kind => 'Full Days'}).first
        @day_home.availability_types << full_time_full_days

        @day_home.save! #this will throw

      #Create the org
      
        org = Organization.new()
        org.city = city
        org.province = province || 'Alberta'        
        org.billing_email = current_user.email
        org.users << current_user
        org.save! #this will throw


        #Now tidy up the links
        loc.organization = org
        loc.save! #this will throw
        
		#Redirect to show
	    if @day_home.save
	      redirect_to betum_path(@day_home)
	    else
	      render :action => :new
	    end
	end

	def show
	end


end
