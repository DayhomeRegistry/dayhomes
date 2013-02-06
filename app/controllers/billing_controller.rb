class BillingController < ApplicationController
  def signup
    @day_home_signup_request = DayHomeSignupRequest.new
  end
  def register
    @day_home_signup_request = DayHomeSignupRequest.new(params[:day_home_signup_request])   

    #I don't know how to make the checkbox mandatory, so we'll check here first
    if(params["ack"].nil?)
      flash[:error] = "Acknowledging the Privacy Policy and Terms of Use is required."
      #raise "param[ack] was missing: " + params.to_json
      return render :action => :signup    
    end

    @error_msg = []
    begin
      DayHomeSignupRequest.transaction do
      #Create the user
        user = User.find_by_email(@day_home_signup_request.contact_email)      
        if(!user.nil?)
          flash.now[:error] = "Looks as though you've already registered.  Do you want to try <a href='"+login_path()+"'>logging in</a> instead?"
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

        if(!org.save)
          handle_org_error(org)
        end

      #Create the location
      #Create the dayhome


      #Just for backwards compatibility, save the DayHomeSignupRequest
        if(!@day_home_signup_request.save)
          handle_day_home_signup_request_error
        end
      end
    rescue Exception => e    
    #raise e          
        if(!e.message.nil?)
          flash[:error] = e.message
        else
          flash[:error] = e
        end
        return render :action => :signup
    end
    return redirect_to :action => :welcome, :controller=>:day_home_signup_requests
  end
  def options
  end
  def upgrade
  end


  private
  def handle_user_error(user)
    user.errors.full_messages.each do |err|
      @error_msg << "user:"+err
    end
    raise @error_msg.join("<br/>").html_safe
  end
  def handle_org_error(org)
    org.errors.full_messages.each do |err|
      @error_msg << err
    end
    raise @error_msg.join("<br/>").html_safe
  end
  def handle_day_home_signup_request_error
    @day_home_signup_request.errors.full_messages.each do |err|
      @error_msg << err
    end
    raise @error_msg.join("<br/>").html_safe
  end
end
