Spree::PaypalController.class_eval do
	def subscription_checkout_request_details order, items
      { :SetExpressCheckoutRequestDetails => {
          :InvoiceID => order.number,
          :BuyerEmail => order.email,
          :ReturnURL => subscribe_paypal_url(:payment_method_id => params[:payment_method_id], :utm_nooverride => 1),
          :CancelURL =>  cancel_paypal_url,
          :SolutionType => payment_method.preferred_solution.present? ? payment_method.preferred_solution : "Mark",
          :LandingPage => payment_method.preferred_landing_page.present? ? payment_method.preferred_landing_page : "Billing",
          :cppheaderimage => payment_method.preferred_logourl.present? ? payment_method.preferred_logourl : "",
          :NoShipping => 1,
          :PaymentDetails => [payment_details(items)],
          :BillingAgreementDetails => {
          	:BillingType => "RecurringPayments",
          	:BillingAgreementDescription => "Dayhome Registry Annual Subscription"
          }
      }}
    end
	def express_subscription
	  order = current_order || raise(ActiveRecord::RecordNotFound)
	  items = order.line_items.map(&method(:line_item))

	  tax_adjustments = order.all_adjustments.tax.additional
	  shipping_adjustments = order.all_adjustments.shipping

	  order.all_adjustments.eligible.each do |adjustment|
	    next if (tax_adjustments + shipping_adjustments).include?(adjustment)
	    items << {
	      :Name => adjustment.label,
	      :Quantity => 1,
	      :Amount => {
	        :currencyID => order.currency,
	        :value => adjustment.amount
	      }
	    }
	  end

	  # Because PayPal doesn't accept $0 items at all.
	  # See #10
	  # https://cms.paypal.com/uk/cgi-bin/?cmd=_render-content&content_ID=developer/e_howto_api_ECCustomizing
	  # "It can be a positive or negative value but not zero."
	  items.reject! do |item|
	    item[:Amount][:value].zero?
	  end

	  pp_request = provider.build_set_express_checkout(subscription_checkout_request_details(order, items))

	  begin
	    pp_response = provider.set_express_checkout(pp_request)
	    if pp_response.success?
	      redirect_to provider.express_checkout_url(pp_response, :useraction => 'commit')
	    else
	      flash[:error] = Spree.t('flash.generic_error', :scope => 'paypal', :reasons => pp_response.errors.map(&:long_message).join(" "))
	      redirect_to checkout_state_path(:payment)
	    end
	  rescue SocketError
	    flash[:error] = Spree.t('flash.connection_failed', :scope => 'paypal')
	    redirect_to checkout_state_path(:payment)
	  end
	end
    #(amount, express_checkout, gateway_options={})
    def confirm
      byebug
	  pp_details_request = provider.build_get_express_checkout_details({
        :Token => params[:token]#express_checkout.token
      })
      pp_details_response = provider.get_express_checkout_details(pp_details_request)
      byebug
      pp_request = provider.build_create_recurring_payments_profile({
	  	:CreateRecurringPaymentsProfileRequestDetails => {
	  		:Token => pp_details_response.get_express_checkout_details_response_details.token,
          	:PayerID => pp_details_response.get_express_checkout_details_response_details.PayerInfo.PayerID,
          	:PaymentDetails => pp_details_response.get_express_checkout_details_response_details.PaymentDetails,
          	:RecurringPaymentsProfileDetails => {
				:BillingStartDate => (Date.today).to_json 
			},
			:ScheduleDetails => {
				:Description => "Dayhome Registry Annual Subscription",
				:PaymentPeriod => {
					:BillingPeriod => "Year",
					:BillingFrequency => 1,
					:Amount => {
						:currencyID => "CAD",
          				:value => pp_details_response.get_express_checkout_details_response_details.PaymentDetails.first.OrderTotal.value
          			}
          		},
          		:ActivationDetails => {
          			:InitialAmount=> {
						:currencyID => "CAD",
          				:value => pp_details_response.get_express_checkout_details_response_details.PaymentDetails.first.OrderTotal.value
          			} ,
          			:FailedInitAmountAction=>"CancelOnFailure"
          		}
          	} 
	    } 
	  })

	  order = current_order || raise(ActiveRecord::RecordNotFound)
      pp_response = provider.create_recurring_payments_profile(pp_request)
      if pp_response.success?
        
	    
	    #this should be called in the before_transition to order.complete
	    if order.complete?
	        flash.notice = Spree.t(:order_processed_successfully)
	        flash[:commerce_tracking] = "nothing special"
	        session[:order_id] = nil
	        redirect_to completion_route(order)
	    else
	    	order.next
	        redirect_to checkout_state_path(order.state)
	    end
      else

        # class << pp_response
        #   def to_s
        #     errors.map(&:long_message).join(" ")
        #   end
        # end
        #order.errors.add(:base, pp_response.errors.map(&:long_message).join(" "))
        flash[:error] = pp_response.errors.map(&:long_message).join(" ")
        redirect_to checkout_state_path(order.state)
      end
      
    end

	def subscribe 
	  byebug
      order = current_order || raise(ActiveRecord::RecordNotFound)
      order.payments.create!({
          :source => Spree::PaypalExpressCheckout.create({
            :token => params[:token],
            :payer_id => params[:PayerID]
          }),
        :amount => order.total,
        :payment_method => payment_method
      })
      order.next
      if order.complete?
        flash.notice = Spree.t(:order_processed_successfully)
        flash[:commerce_tracking] = "nothing special"
        session[:order_id] = nil
        redirect_to completion_route(order)
      else
        redirect_to checkout_state_path(order.state)
      end
      
	end
end