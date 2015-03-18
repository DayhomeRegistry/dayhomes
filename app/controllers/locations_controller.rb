class LocationsController < ApplicationController

	def edit
		@organization = Organization.find(params["organization_id"])
		@location = @organization.locations.find(params["id"])
		#raise "EDIT:" + @location.to_json
	end
	def update
		@organization = Organization.find(params["organization_id"])
		@location = Location.find(params[:id])
    	@location.assign_attributes(params[:location]) 
		if @location.save
    		flash[:success] = "Locale successfully updated!"
    	redirect_to organization_path(@organization)
    else
    	render :action => :edit
    end
	end

	def destroy
		@organization = Organization.find(params["organization_id"])
		@location = @organization.locations.find(params["id"])
		
		#bail if this is the only location
		if @organization.locations.count ==1
			flash[:error] = "You can't remove your only locale!"
			return redirect_to organization_path(@organization)
		end

		begin
			Location.transaction do
				#need to move dayhomes and users
				first = @organization.locations.where("id != #{params["id"]}").first
				first.day_homes << @location.day_homes
				first.users << @location.users

				#now kill the beast
		    if @location.destroy
		    	flash[:success] = "#{@location.name} successfully removed."
		    else    	
		      	flash[:error] = "Unable to remove #{@location.name}"
		    end
		end
		rescue Exception => e    
	        #raise e          
	        if(!e.message.nil?)
	          	flash[:error] = e.message
	        else
	          	flash[:error] = e
	        end  
		end
	    redirect_to organization_path(@organization)
	end

	def new
		#you can't create one if you're at your limit
		@organization = Organization.find(params["organization_id"])
	    plan = Plan.find_by_plan(@organization.plan)
		#raise organization.users.count().to_s
	    if(plan.locales <= @organization.locations.count())
	      flash[:error]="Sorry, you've reached your locales limit. Adding a locale for a fee is coming soon."
	      return redirect_to organization_path(@organization)
	    end

		@location = Location.new
		#raise "NEW:" + @organization.to_json
	end
	def create
		@organization = Organization.find(params["organization_id"])
    	@location = Location.new(params[:location])
    	@location.organization=@organization
    
	    if @location.save
	    	flash.now[:notice] = "You successfully added a new locale!"
	    	redirect_to organization_path(@organization)
	    else
	    	render :action => :new
	    end

	end

end
