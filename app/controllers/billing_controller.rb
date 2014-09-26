class BillingController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_user, :except=>[:signup, :register, :get_coupon]
  before_filter :require_user_to_be_organization_admin, :except=>[:signup, :register, :get_coupon]
  
  def signup
    if(current_user)
      redirect_to :action=>:options
    end
    @day_home_signup_request = DayHomeSignupRequest.new
    @existing = Plan.find_by_plan("baby50")
    @packages = {}
    @communities = Community.all
    
    Plan.where("inactive is null").order(:price).order("subscription DESC").each do |p|
      @packages.merge!({"#{p.id}" => p}) #unless p===@existing
    end
  end
  def register

    staff = 0
    locales = 0

    @day_home_signup_request = DayHomeSignupRequest.new(params[:day_home_signup_request])   
    @day_home_signup_request.plan=params[:plan]
    @existing = Plan.find_by_plan("baby50")
    @packages = {}
    Plan.where("inactive is null").order(:price).order("subscription DESC").each do |p|
      @packages.merge!({"#{p.id}" => p}) #unless p===@existing
    end
    @communities = Community.all
      

    if(!params[:staff].blank?)
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
      #Check for a coupon
        @coupon = nil
        if(!@day_home_signup_request.coupon.blank?)
          begin
            @coupon = Stripe::Coupon.retrieve(@day_home_signup_request.coupon)

          rescue Stripe::StripeError => e
            # Invalid parameters were supplied to Stripe's API
            raise e.json_body[:error][:message]
          end
        end

     
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

      #Find or create the community
        createdCommunity = false
        if (!params["community"]["id"].blank?)
          community = Community.find(params["community"]["id"])
        else
          community = Community.new()
          community.name=params["community"]["name"]
          if(!community.save)
            raise "It seems there's an issue with starting that community.  Perhaps try another name?"
          else
            createdCommunity=true
          end
        end

      #Create the location
        loc = Location.new()
        loc.name = @day_home_signup_request.day_home_city || 'Edmonton'
        loc.community=community
        if(!loc.save)
          handle_location_error(loc)
        end
        user.location = loc;
        if(!user.save)
          handle_user_error(user)
        end

      #Create the dayhome
        @day_home = DayHome.create_from_signup(@day_home_signup_request)
        @day_home.update_attributes(params[:day_home])
        @day_home.email = @day_home_signup_request.contact_email
        
        @day_home.location = loc
  
        #add default availability
        full_time_full_days = AvailabilityType.where({:availability => 'Full-time', :kind => 'Full Days'}).first
        @day_home.availability_types << full_time_full_days

        if(!@day_home.save)
          handle_dayhome_error
        end


      #Create the org
      
        org = Organization.new()
        org.stripe_coupon_code = @coupon.nil? ? nil : @coupon.id
        org.name = @day_home_signup_request.day_home_name
        org.city = @day_home_signup_request.day_home_city
        org.province = @day_home_signup_request.day_home_province
        org.street1 = @day_home_signup_request.day_home_street1
        #org.street2
        org.postal_code = @day_home_signup_request.day_home_postal_code
        org.billing_email = @day_home_signup_request.contact_email
        org.phone_number = @day_home_signup_request.contact_phone_number
        org.users << user

        #update any affiliate data
        if request.env['affiliate.tag'] && affiliate = Organization.find_by_affiliate_tag(request.env['affiliate.tag'])
          org.mentor = affiliate
        end

        #OK, let get the org into the database before we charge the card
        if(!org.save)
          handle_org_error(org)
        end

        #Now tidy up the links
        loc.organization = org
        if(!loc.save)
          handle_location_error(loc)
        end

        #and now we charge the card
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
      

      #Save the DayHomeSignupRequest as this sends all the "we got your signup" emails
        if(!@day_home_signup_request.save)
          handle_day_home_signup_request_error
        end

      #Now that we're all done, email them their password set instructions
        UserMailer.new_user_password_instructions(user).deliver  
        if(createdCommunity)
          DayHomeMailer.new_community(org,community).deliver
        end
      #end transaction
      end

    rescue => e    
      debugger
      if(!e.message.nil?)
        flash.now['page-error'] = e.message
        logger.error e.message
      else
        flash.now['page-error'] = e
        logger.error e
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
    @packages = {"#{@existing.id}" => @existing}
    Plan.where("inactive is null").where(subscription: "yr").order( price: :asc).each do |p|
      @packages.merge!({"#{p.id}" => p}) #unless p===@existing
    end
    Plan.where("inactive is null").where(subscription: "mth").order( price: :asc).each do |p|
      @packages.merge!({"#{p.id}" => p}) #unless p===@existing
    end
    if(!@organization.stripe_customer_token.nil?)
      customer = Stripe::Customer.retrieve(@organization.stripe_customer_token)
      card = customer.cards.retrieve(customer.default_card)

      #raise customer.to_json
      @credit_card = {
        last4: card.last4,
        month: card.exp_month,
        year: card.exp_year
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
    if(!@organization.stripe_customer_token.nil?)
      
      customer = Stripe::Customer.retrieve(@organization.stripe_customer_token)
      card = customer.cards.retrieve(customer.default_card)

      #raise customer.to_json
      @credit_card = {
        last4: card.last4,
        month: card.exp_month,
        year: card.exp_year
      }  
    end
    @existing = Plan.find_by_plan(@organization.plan)
    anew = Plan.find(params["choose-package"])

    @upgrade = Upgrade.new();
    @upgrade.organization = @organization
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
          DayHomeMailer.day_home_upgrade(@upgrade).deliver      
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
          DayHomeMailer.day_home_upgrade(@upgrade).deliver     
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
    
    saved = @organization.buy_features(params[:number])
    error = ""
    if (@organization.errors.count>0)
      error = @organization.errors.messages[:base].map(&:inspect).join(',')
    end
    if(saved)
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
    @organization = current_user.organization
    #make sure the freebees are up to date before we go checking if they have enough
    @organization.update_free_features

    #ok, now do the math
    @day_home = @organization.day_homes.find(params["day_home_id"])
    respond_to do |format|  
      if @day_home.activate(false,params[:months])
        format.html { return redirect_to edit_day_home_path(@day_home) }  
        format.js  {return render :json=>"Success"}
      else  
        error = "You don't have enough credits to feature your dayhome for #{params[:months]} #{params[:months].to_i>1?'months':'month'}.  "
        error = error + "You might want to go <a href='" + billing_extras_path() + "'>buy extras</a>."
        format.html { return redirect_to edit_day_home_path(@day_home), :notice=>error}  
        format.js { return render :text=>error, :status=>500}
      end  
    end  
  end

  def get_coupon
      @coupon=nil
      begin
        @coupon = Stripe::Coupon.retrieve(params[:coupon])

      
      rescue Stripe::InvalidRequestError => e
        # Invalid parameters were supplied to Stripe's API
        error =  e.json_body[:error][:message]
        respond_to do |format|
            format.html {return render json: error}
            format.js { return render :text=>error, :status=>500}
        end
      #rescue Stripe::CardError => e
        # Since it's a decline, Stripe::CardError will be caught  
      #rescue Stripe::AuthenticationError => e
        # Authentication with Stripe's API failed
        # (maybe you changed API keys recently)
      #rescue Stripe::APIConnectionError => e
        # Network communication with Stripe failed
      #rescue Stripe::StripeError => e
        # Display a very generic error to the user, and maybe send
        # yourself an email
      rescue => e
        # Something else happened, completely unrelated to Stripe
        error =  e.json_body[:error][:message]
        respond_to do |format|
            format.html {return render json: error, :status=>500}
            format.js { return render :text=>error, :status=>500}
        end
      end
      
      if (@coupon)
        respond_to do |format|
            format.html {render json: 'Coupon #{@coupon.name} is valid.'}
            format.js { render json: @coupon }
        end
      else
        error = 'That is not a valid coupon or that coupon has expired.'
        respond_to do |format|
            format.html {return render json: error}
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
    debugger
    @day_home.errors.messages.each do |err|
      @error_msg << err[1][0]+" (dayhome)"
    end
    raise @error_msg.join("<br/>").html_safe
  end
end
