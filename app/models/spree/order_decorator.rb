Spree::Gateway::PayPalExpress.class_eval do
	def subscribe(amount, express_checkout, gateway_options={})
	  pp_details_request = provider.build_get_express_checkout_details({
        :Token => express_checkout.token
      })
      pp_details_response = provider.get_express_checkout_details(pp_details_request)

      pp_request = provider.build_create_recurring_payments_profile({
	  	:CreateRecurringPaymentsProfileRequestDetails => {
	  		:Token => express_checkout.token,
          	:PayerID => express_checkout.payer_id,
          	#:PaymentDetails => pp_details_response.get_express_checkout_details_response_details.PaymentDetails
          	:RecurringPaymentsProfileDetails => {
				:BillingStartDate => (Date.today + 1.year).to_json 
			},
			:ScheduleDetails => {
				:Description => "Dayhome Registry Annual Subscription",
				:PaymentPeriod => {
					:BillingPeriod => "Year",
					:BillingFrequency => 1,
					:Amount => {
						:currencyID => "CAD",
          				:value => "50" 
          			} 
          		} 
          	} 
	    } 
	  })

      pp_response = provider.create_recurring_payments_profile(pp_request)
      if pp_response.success?
        # We need to store the transaction id for the future.
        # This is mainly so we can use it later on to refund the payment if the user wishes.
        transaction_id = pp_response.do_express_checkout_payment_response_details.payment_info.first.transaction_id
        express_checkout.update_column(:transaction_id, transaction_id)
        # This is rather hackish, required for payment/processing handle_response code.
        Class.new do
          def success?; true; end
          def authorization; nil; end
        end.new
      else
        class << pp_response
          def to_s
            errors.map(&:long_message).join(" ")
          end
        end
        pp_response
      end
	end
end

Spree::Order.class_eval do
	def add_subscription
		# this is where we do cool stuff
		byebug
		payment = self.payments.first
		if(payment.source_type == 'Spree::PaypalExpressCheckout')
			express_checkout = self.payments.first.source
			subscription_checkout = Spree::PaypalExpressCheckout.create({
	          :token => express_checkout.token,
	          :payer_id => express_checkout.PayerID
	        })
			paypal_token = express_checkout.token
		elsif(payment.source_type == 'Spree::CreditCard')
			stripe_token = self.payments.first.source.gateway_customer_profile_id

		end
	end
	remove_checkout_step :delivery
	state_machine.after_transition :to => :complete, :do => :add_subscription
 #  	checkout_flow do
	#   # 	if(->(order){order.bill_address.nil?})
	#   # 		go_to_state :address
	# 		# go_to_state :complete
	#   # 	else
	# 	    go_to_state :address#, if: ->(order){order.bill_address.nil?}
	# 		#go_to_state :delivery #, if: ->(order){!order.digital}
	# 		go_to_state :payment #, if: ->(order) {
	# 		# 	order.update_totals
	# 		# 	order.payment_required?
	# 		# }
	# 		go_to_state :confirm, if: ->(order) { order.confirmation_required? }
	# 	# end
	# end
	# Spree::Order.state_machine.before_transition :to => :address, :do => :copy_address

  # If the user has a single dayhome, copy the address to the order
 #  def copy_address
 #    byebug
 #    address = Spree::Address.new
 #    if(current_user)
	#     address.first_name = current_user.first_name
	#     address.last_name = current_user.last_name
	#     if(current_user.location)
	# 	    org = current_user.location.organization
	# 	    address.address1=org.street1
	# 	end
	#     #address.save
	# end
 #    self.bill_address = address
 #  end

	def create_recurring_payments_profile(token)

	  # ##Build request object
	  @create_recurring_payments_profile = @api.build_create_recurring_payments_profile({
	  	:CreateRecurringPaymentsProfileRequestDetails => {

	      # Either EC token or a credit card number is required.If you include
	      # both token and credit card number, the token is used and credit card number is
	      # ignored
	      # In case of setting EC token,
	      # `:Token => "EC-5KH01765D1724703R"`
	      :Token => token,
	      # A timestamped token, the value of which was returned in the response
	      # to the first call to SetExpressCheckout. Call
	      # CreateRecurringPaymentsProfile once for each billing
	      # agreement included in SetExpressCheckout request and use the same
	      # token for each call. Each CreateRecurringPaymentsProfile request
	      # creates a single recurring payments profile.
	      # `Note:
	      # Tokens expire after approximately 3 hours.`

	      # Credit card information for recurring payments using direct payments.
	      # :CreditCard => {

	      #   # Type of credit card. For UK, only Maestro, MasterCard, Discover, and
	      #   # Visa are allowable. For Canada, only MasterCard and Visa are
	      #   # allowable and Interac debit cards are not supported. It is one of the
	      #   # following values:
	      #   # 
	      #   # * Visa
	      #   # * MasterCard
	      #   # * Discover
	      #   # * Amex
	      #   # * Solo
	      #   # * Switch
	      #   # * Maestro: See note.
	      #   # `Note:
	      #   # If the credit card type is Maestro, you must set currencyId to GBP.
	      #   # In addition, you must specify either StartMonth and StartYear or
	      #   # IssueNumber.`
	      #   :CreditCardType => "Visa",

	      #   # Credit Card Number
	      #   :CreditCardNumber => "4904202183894535",

	      #   # Credit Card Expiration Month
	      #   :ExpMonth => 12,

	      #   # Credit Card Expiration Year
	      #   :ExpYear => 2022,

	      #   # CVV number of the credit card
	      #   :CVV2 => "962" },

	      # You can include up to 10 recurring payments profiles per request. The
	      # order of the profile details must match the order of the billing
	      # agreement details specified in the SetExpressCheckout request
	      :RecurringPaymentsProfileDetails => {

	        # The date when billing for this profile begins.
	        # `Note:
	        # The profile may take up to 24 hours for activation.`
	        :BillingStartDate => (Date.today + 1.year).to_json },

	      # Describes the recurring payments schedule, including the regular
	      # payment period, whether there is a trial period, and the number of
	      # payments that can fail before a profile is suspended  
	      :ScheduleDetails => {

	        # Description of the recurring payment.
	        # `Note:
	        # You must ensure that this field matches the corresponding billing
	        # agreement description included in the SetExpressCheckout request.`
	        :Description => "Welcome to the world of shopping where you get everything",

	        # Regular payment period for this schedule
	        :PaymentPeriod => {

	          # Unit for billing during this subscription period. It is one of the
	          # following values:
	          # 
	          # * Day
	          # * Week
	          # * SemiMonth
	          # * Month
	          # * Year
	          # For SemiMonth, billing is done on the 1st and 15th of each month.
	          # `Note:
	          # The combination of BillingPeriod and BillingFrequency cannot exceed
	          # one year.`
	          :BillingPeriod => "Day",

	          # Number of billing periods that make up one billing cycle.
	          # The combination of billing frequency and billing period must be less
	          # than or equal to one year. For example, if the billing cycle is
	          # Month, the maximum value for billing frequency is 12. Similarly, if
	          # the billing cycle is Week, the maximum value for billing frequency is
	          # 52.
	          :BillingFrequency => 10,
	          
	          # Billing amount for each billing cycle during this payment period.
	          # This amount does not include shipping and tax amounts.
	          # `Note:
	          # All amounts in the CreateRecurringPaymentsProfile request must have
	          # the same currency.`
	          :Amount => {
	          	:currencyID => "USD",
	          	:value => "5" } } } } })

	  # ##Make API call & get response
	  @create_recurring_payments_profile_response = @api.create_recurring_payments_profile(@create_recurring_payments_profile)
	  
	  # ##Access Response
	  # ###Success Response
	  @create_recurring_payments_profile_response.Timestamp
	  @create_recurring_payments_profile_response.Ack
	  @create_recurring_payments_profile_response.CorrelationID
	  @create_recurring_payments_profile_response.Version
	  @create_recurring_payments_profile_response.Build
	  @create_recurring_payments_profile_response.CreateRecurringPaymentsProfileResponseDetails

	  if @create_recurring_payments_profile_response.ack == "Success"

	    #A unique identifier for future reference to the details of this recurring payment.
	    @api.logger.info("Profile ID : " +  @create_recurring_payments_profile_response.CreateRecurringPaymentsProfileResponseDetails.ProfileID)

	    # ###Error Response    
	  else
	  	@api.logger.error(@create_recurring_payments_profile_response.Errors[0].LongMessage)
	  end
	  @create_recurring_payments_profile_response
	end
end
