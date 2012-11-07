class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.page(params[:page] || 1).per(params[:per_page] || 10)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    
    if @user.save_with_payment
      redirect_to admin_users_path
    else
      render :action => :new
    end
  end

  def edit
    @user = User.find(params[:id])
    
    if(!@user.stripe_customer_token.nil?)
      customer = Stripe::Customer.retrieve(@user.stripe_customer_token)
      #raise customer.to_json
      @credit_card = {
        last4: customer.active_card.last4,
        month: customer.active_card.exp_month,
        year: customer.active_card.exp_year
      }
      
    end
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(params[:user])           
    if @user.stripe_card_token.nil?
      if @user.save_with_payment
        redirect_to admin_users_path
      else
        render :action => :edit
      end
    else
      if @user.save
        redirect_to admin_users_path
      else
        render :action => :edit
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    unless @user.destroy
      flash[:error] = "Unable to remove #{@user.full_name}"
    end

    redirect_to admin_users_path
  end
  
end
