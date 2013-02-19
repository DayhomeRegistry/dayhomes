class BillingController < ApplicationController
  def signup
    @day_home_signup_request = DayHomeSignupRequest.new
  end
  def register
    staff = 0
    locales = 0

    @day_home_signup_request = DayHomeSignupRequest.new(params[:day_home_signup_request])   
    @day_home_signup_request.plan=params[:plan]
    
    if(params[:staff])
      staff = Integer(params[:staff])
    end
    if(params[:locales])
      locales = Integer(params[:staff])
    end

    #I don't know how to make the checkbox mandatory, so we'll check here first
    if(params["ack"].nil?)
      flash.now['page-error'] = "Acknowledging the Privacy Policy and Terms of Use is required."
      #raise flash.to_json
      #raise "param[ack] was missing: " + params.to_json
      return render :action => :signup    
    end

    @error_msg = []
    begin
      DayHomeSignupRequest.transaction do
      
      #Create the user
        user = User.find_by_email(@day_home_signup_request.contact_email)      
        if(!user.nil?)
          flash.now['page-error'] = "Looks as though you've already registered.  Do you want to try <a href='"+login_path()+"'>logging in</a> instead?"
          return render :action => :signup
        end
        #no one here, create a new one
        user = User.new_from_signup_request(@day_home_signup_request)
        # Need to set the ack date
        user.privacy_effective_date = Time.now()
        if(!user.save)
          handle_user_error(user)
        end

      #Create the org
        org = Organization.new()
        org.name = @day_home_signup_request.day_home_name
        org.city = @day_home_signup_request.day_home_city
        org.province = @day_home_signup_request.day_home_province
        org.street1 = @day_home_signup_request.day_home_street1
        #org.street2
        org.postal_code = @day_home_signup_request.day_home_postal_code
        org.billing_email = @day_home_signup_request.contact_email
        org.phone_number = @day_home_signup_request.contact_phone_number
        org.users << user

        if(@day_home_signup_request.plan!="baby") 
          org.stripe_card_token = @day_home_signup_request.stripe_card_token
          org.plan = @day_home_signup_request.plan
          if !org.save_with_payment 
            handle_org_error(org)
          end
        else
          if(!org.save)
            handle_org_error(org)
          end
        end
      #Create the location
        loc = Location.new()
        loc.name = @day_home_signup_request.day_home_city || 'Edmonton'
        loc.organization = org

        if(!org.save)
          handle_location_error(loc)
        end

      #Create the dayhome
        @day_home = DayHome.create_from_signup(@day_home_signup_request)
        @day_home.update_attributes(params[:day_home])
        @day_home.email = @day_home_signup_request.contact_email
        
        @day_home.location = loc

        if(!@day_home.save)
          handle_dayhome_error
        end

      #Just for backwards compatibility, save the DayHomeSignupRequest
        if(!@day_home_signup_request.save)
          handle_day_home_signup_request_error
        end
      end
    rescue Exception => e    
      #raise e          
      if(!e.message.nil?)
        flash.now['page-error'] = e.message
      else
        flash.now['page-error'] = e
      end
      return render :action => :signup
    end
    return redirect_to :action => :welcome
  end
  def welcome
  end
  def options
    @organization = current_user.organization
    @upgrade = Upgrade.new()
    @existing = Plan.find_by_name(@organization.plan)
    @packages = {}
    Plan.all.each do |p|
      @packages.merge!({"#{p.id}" => p}) #unless p===@existing
    end
    
  end
  def upgrade
    raise params.to_json
  end

  def extras
    @organization = current_user.organization
    #raise @organization.day_homes.joins(:features).to_sql
  end
  def add
    raise params.to_json
  end

  private
  def handle_user_error(user)
    user.errors.full_messages.each do |err|
      @error_msg << err+" (user)"
    end
    raise @error_msg.join("<br/>").html_safe
  end
  def handle_org_error(org)
    org.errors.full_messages.each do |err|
      @error_msg << err+" (org)"
    end
    raise @error_msg.join("<br/>").html_safe
  end
  def handle_location_error(loc)
    loc.errors.full_messages.each do |err|
      @error_msg << err+" (location)"
    end
    raise @error_msg.join("<br/>").html_safe
  end 
  def handle_day_home_signup_request_error
    @day_home_signup_request.errors.full_messages.each do |err|
      @error_msg << err+" (signup request)"
    end
    raise @error_msg.join("<br/>").html_safe
  end
  def handle_dayhome_error
    @day_home.errors.full_messages.each do |err|
      @error_msg << err+" (dayhome)"
    end
    raise @error_msg.join("<br/>").html_safe
  end
end
