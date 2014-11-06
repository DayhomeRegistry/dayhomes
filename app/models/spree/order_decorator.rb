
Spree::Order.state_machine.before_transition :to => :address, :do => :copy_address

Spree::Order.class_eval do
  checkout_flow do
  	#byebug
    go_to_state :address#, if: ->(order){order.bill_address.nil?}
	go_to_state :delivery #, if: ->(order){!order.digital}
	go_to_state :payment, if: ->(order) {
	order.update_totals
	order.payment_required?
	}
	go_to_state :confirm, if: ->(order) { order.confirmation_required? }
	go_to_state :complete
  end

  # If the user has a single dayhome, copy the address to the order
  def copy_address
    byebug
    org = current_user.location.organization
    address = Spree::Address.new
    address.first_name = current_user.first_name
    address.last_name = current_user.last_name
    address.save
    self.bill_address = address
  end


end