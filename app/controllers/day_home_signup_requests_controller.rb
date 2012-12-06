class DayHomeSignupRequestsController < ApplicationController
  def index
    redirect_to :action=>:new
  end
  
  def new
    @day_home_signup_request = DayHomeSignupRequest.new
    if(!params[:plan].blank? && params[:plan]=="mama")
      @day_home_signup_request.plan = "mama"
    end
    if(!params[:plan].blank? && params[:plan]=="papa")
      @day_home_signup_request.plan = "papa"
    end
    if(!current_user.nil? && !current_user.stripe_customer_token.nil?)
      customer = Stripe::Customer.retrieve(current_user.stripe_customer_token)
      #raise customer.to_json
      @credit_card = {
        last4: customer.active_card.last4,
        month: customer.active_card.exp_month,
        year: customer.active_card.exp_year
      }  
    end
  end
  
  def create  
      
    # Capture the signup request and send email
    @day_home_signup_request = DayHomeSignupRequest.new(params[:day_home_signup_request])    

    #I don't know how to make the checkbox mandatory, so we'll check here first
    if(params["ack"].nil?)
      flash[:error] = "Acknowledging the Privacy Policy and Terms of Use is required."
      #raise "param[ack] was missing: " + params.to_json
      return render :action => :new    
    end
    #raise "param[ack] was there: " + params.to_json
    
    @error_msg = []
    ActiveRecord::Base.transaction do
      begin
        # Create user, if necessary
        user = find_or_create_user
        # Need to set the ack date
        user.privacy_effective_date = Time.now()

        if(user.agency_admin?)
          agency = user.agencies.first
          # Create a dayhome
          @day_home = DayHome.create_from_signup(@day_home_signup_request)
          @day_home.update_attributes(params[:day_home])
          if @day_home.save
            if @day_home_signup_request.save
              agency.add_day_home(@day_home)
              agency.save
            else              
              handle_day_home_signup_request_error
              return render :action => :new
            end
          else
            handle_day_home_error
            return render :action => :new
          end
        else
          user.stripe_card_token = @day_home_signup_request.stripe_card_token
          
          if user.save_with_payment 
                  
            # Create a dayhome
            @day_home = DayHome.create_from_signup(@day_home_signup_request)
            @day_home.update_attributes(params[:day_home])

            if @day_home.save
              if @day_home_signup_request.save

                # Bind dayhome to user
                user.add_day_home(@day_home)

                #redirect_to root_path, :notice => "Thanks for adding your DayHome! We will contact you soon!"
                return redirect_to :action => :welcome   
              else
                handle_day_home_signup_request_error
                return render :action => :new
              end
            else
              handle_day_home_error
              return render :action => :new
            end
          else
            handle_user_error
            return render :action => :new
          end
        end
      rescue Exception => e              
        if(!e.message.nil?)
          flash[:error] = e.message
        else
          flash[:error] = e
        end
        return render :action => :new
      end
    end
  end

  def welcome
  end

  private
  def find_or_create_user
    user = current_user
    if current_user.nil?
      #find user by email
      user = User.find_by_email(@day_home_signup_request.contact_email)      
      if user.nil?
        user = User.find_by_email(@day_home_signup_request.day_home_email)
        if user.nil?
            #no one here, create a new one
            user = User.new_from_signup_request(@day_home_signup_request)
            user.save   
            
            
            #email them their password set instructions
            UserMailer.new_user_password_instructions(user).deliver                        
            
            reset_session
        end        
      end
    end
    return user
  end

  def handle_day_home_error    
    @day_home.errors.full_messages.each do |err|
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

  def handle_user_error
    user.errors.full_messages.each do |err|
      @error_msg << err
    end
    raise @error_msg.join("<br/>").html_safe
  end
end