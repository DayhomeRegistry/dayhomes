require 'spree/core/validators/email'
Spree::CheckoutController.class_eval do
  before_filter :check_authorization
  before_filter :check_registration, :except => [:registration, :update_registration]

  def registration
    @user = User.new
  end

  def update_registration
    if params[:order][:email] =~ Devise.email_regexp && current_order.update_attribute(:email, params[:order][:email])
      redirect_to checkout_path
    else
      flash[:registration_error] = t(:email_is_invalid, :scope => [:errors, :messages])
      @user = User.new
      render 'registration'
    end
  end
  # Override to set the address
  def before_address
    #byebug
    # if the user has a default address, a callback takes care of setting
    # that; but if he doesn't, we need to build an empty one here
    if(@order.bill_address.nil?)
      address = Spree::Address.build_default
      if(current_user)
        address.first_name = current_user.first_name
        address.last_name = current_user.last_name

        if(current_user.location)
          org = current_user.location.organization
          address.address1=org.street1
        end
      end
      @order.bill_address ||= address
      @order.ship_address ||= address if @order.checkout_steps.include?('delivery') 
    end
  end

  private
    def order_params
      if params[:order]
        params.require(:order).permit(:email)
      else
        {}
      end
    end

    def skip_state_validation?
      %w(registration update_registration).include?(params[:action])
    end

    def check_authorization
      authorize!(:edit, current_order, cookies.signed[:guest_token])
    end

    # Introduces a registration step whenever the +registration_step+ preference is true.
    def check_registration
      #return unless Spree::Auth::Config[:registration_step]
      return if current_user or current_order.email
      store_location
      store_order
      redirect_to spree_signup_path#spree.checkout_registration_path
    end

    # Overrides the equivalent method defined in Spree::Core.  This variation of the method will ensure that users
    # are redirected to the tokenized order url unless authenticated as a registered user.
    def completion_route
      return order_path(@order) if spree_current_user
      spree.token_order_path(@order, @order.guest_token)
    end

    def store_order
      if(current_order)
        session['spree_guest_order_number'] = current_order.number
      end
    end
end
