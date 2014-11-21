Spree::Payment::Processing.module_eval do
	def subscribe!
		byebug
		raise Spree::Core::GatewayError.new(Spree.t(:no_payment_found)) if !(payment_method && payment_method.subscribe?)
        handle_payment_preconditions { process_subscription }
	end

	def process_subscription
		started_processing!
        result = gateway_action(source, :subscribe, :complete)
        # This won't be called if gateway_action raises a GatewayError
        capture_events.create!(amount: amount)
	end
	
end