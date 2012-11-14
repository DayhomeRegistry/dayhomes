class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :update]
  
  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to root_path
      flash[:notice] = "Thanks for signing up #{@user.full_name}!"
    else
      render :action => :new
    end
  end

  def edit
    #raise current_user.stripe_customer_token
    if(!current_user.stripe_customer_token.nil?)
      customer = Stripe::Customer.retrieve(current_user.stripe_customer_token)
      #raise customer.to_json
      @credit_card = {
        last4: customer.active_card.last4,
        month: customer.active_card.exp_month,
        year: customer.active_card.exp_year
      }
      
    end
  end

  def update
    current_user.assign_attributes(params[:user])
    if current_user.save_with_payment
      redirect_to user_path(current_user)
    else
      render :action => :edit
    end
  end

end
