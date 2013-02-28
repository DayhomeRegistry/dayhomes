class BillingController < ApplicationController
  before_filter :require_user, :except=>[:signup, :register]
  before_filter :require_user_to_be_organization_admin, :except=>[:signup, :register]
  
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
    @existing = Plan.find_by_plan(@organization.plan)
    @packages = {}
    Plan.all.each do |p|
      @packages.merge!({"#{p.id}" => p}) #unless p===@existing
    end

    if(!@organization.stripe_customer_token.nil?)
      
      customer = Stripe::Customer.retrieve(@organization.stripe_customer_token)
      #raise customer.to_json
      @credit_card = {
        last4: customer.active_card.last4,
        month: customer.active_card.exp_month,
        year: customer.active_card.exp_year
      }  
    end
    
  end
  def upgrade
    #{"utf8":"\u2713","_method":"put","authenticity_token":"x5RaRd1i0qB3gsrwBqKGXCwtV+5h1AzJeetIJVrCCAE=","choose-package":"4","plan":"goldilocks","staff":"","locales":"0","upgrade":{"stripe_card_token":""},"controller":"billing","action":"upgrade"}

    @packages = {}
    Plan.all.each do |p|
      @packages.merge!({"#{p.id}" => p}) #unless p===@existing
    end

    @organization = current_user.organization
    @existing = Plan.find_by_plan(@organization.plan)
    anew = Plan.find(params["choose-package"])

    @upgrade = Upgrade.new();
    @upgrade.old_plan_id = @existing.id
    @upgrade.new_plan_id = anew.id
    @upgrade.effective_date = Time.now()

    #are we downgrading to free?
    if(anew.price == 0)
      @organization.plan = anew.plan
      if(!@organization.save_with_payment)
        flash.now[:error] = "Something seems to have gone wrong."
        return render :action=>:options
      else
        if(@upgrade.save)
          flash[:message] = "Congrats! You're now on the #{anew.name} plan."
        else
          flash.now[:error] = "Something seems to have gone wrong."
          return render :action=>:options
        end
      end
    else
      saved = true
      @organization.plan = anew.plan

      #did we change/add the credit card?
      token = params[:upgrade]["stripe_card_token"]

      if !token.nil?
        @organization.stripe_card_token = token
        saved = @organization.save_with_payment
        #raise @organization.errors.to_json
      else
        saved = @organization.save
      end
      if(!saved)
        return render :action=>:options
      else
        if(@upgrade.save)
          flash[:message] = "Congrats! You're now on the #{anew.name} plan."
        else
          return render :action=>:options
        end
      end
    end

    redirect_to :action=>:options

  end

  def extras
    @organization = current_user.organization
    #raise @organization.day_homes.joins(:features).to_sql
    sql = Feature.joins(:organization).where("organizations.id = ?",@organization.id).where("end > now()").to_sql
    @features = Feature.find_by_sql("select organization_id,day_home_id,min(start) as start, max(end) as end from (#{sql}) as active group by organization_id,day_home_id")
    
  end
  def add
    @organization = current_user.organization
    
    saved = true
    error = ""
    begin
      Feature.transaction do
        params[:number].to_i.times do |i|
          feature = Feature.new()
          feature.organization = @organization
          saved = saved & feature.save

        end
      end
    rescue Exception => e
      if(!e.message.nil?)
        error = e.message
      else
        error = e
      end
    end
    
    respond_to do |format|  
      if saved
        format.html { redirect_to :action=>"extras" }  
        format.js  {render :json=>@organization.feature_count}
      else  
        format.html { render :action => "extras", :notice => error }  
        format.js { render :text=>error, :status=>500}
      end  
    end  
  end
  def activate
    #activate a feature
    @organization = current_user.organization
    @day_home = @organization.day_homes.find(params["day_home_id"])
    features = @organization.features
    features = features.where("day_home_id is null")

    saved = true
    last_date = Time.now()
    #check if there are enough credits
    how_many_months = params["months"].to_i
    if(how_many_months<features.count)
      Feature.transaction do
        how_many_months.times do |f|
          feature = features[f]
          feature.day_home = @day_home
          feature.start = last_date
          last_date = last_date.advance(:months => 1)
          feature.end = last_date
          saved = saved && feature.save
        end
      end
    else
      respond_to do |format|  
        error = "You don't have enough credits to feature your dayhome for #{how_many_months} #{how_many_months>1?'months':'month'}.  "
        error = error + "You might want to go <a href='" + billing_extras_path() + "'>buy extras</a>."

        format.html { return redirect_to edit_day_home_path(@day_home), :notice=>error }  
        format.js { return render :text=>error, :status=>500}        
      end  
    end
    respond_to do |format|  
      if saved
        format.html { return redirect_to edit_day_home_path(@day_home) }  
        format.js  {return render :json=>"Success"}
      else  
        format.html { return redirect_to edit_day_home_path(@day_home), :notice=>error}  
        format.js { return render :text=>error, :status=>500}
      end  
    end  
    
    
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
