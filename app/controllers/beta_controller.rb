class BetaController < ApplicationController
	before_filter :authenticate_user!, :except => [:index, :list]

  # Redirect default
  def show
    redirect_to beta_list_path()
  end
  
	# Landing page
	def list
		@disable_subnav=true
	end

  def dashboard
  	@organization = current_user.organization
  end
  def profile
  	@org = current_user.organization
  end
  def update_profile
  	p = params
  	byebug
  	@org = Organization.find(params[:organization_id])
  	@org.update_attributes(params.require(:organization).permit(permitted_organization_attributes))

  	render "profile"

  end
  def plan
  	
    @day_home_signup_request = DayHomeSignupRequest.new
    @existing = Plan.find_by_plan("baby50")
    @packages = {}
    @communities = Community.all
    
    @organization = current_user.organization

    Plan.where("inactive is null").where(@organization.individual? ? "org_type = 'individual'" : "org_type = 'group'").order(:monthly_price).each do |p|
      @packages.merge!({"#{p.id}" => p}) #unless p===@existing
    end
    

  end

	def new
		@params = params
	end

	private
	def permitted_organization_attributes
	  [:name, :billing_email,:street1,:city,:province,:postal_code,:phone_number]
	end

end
