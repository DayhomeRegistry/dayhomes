Spree::OrdersController.class_eval do
	# Override!
	# Adds a new item to the order (creating a new order if none already exists)
    def populate
      populator = Spree::OrderPopulator.new(current_order(create_order_if_necessary: true), current_currency)
      if populator.populate(params[:variant_id], params[:quantity], params[:options])
        respond_with(@current_order) do |format|
          format.html { 
          	if(@current_order.has_subscription?)
          		redirect_to checkout_state_path(@current_order.checkout_steps.first)
          	else
          		redirect_to cart_path 
          	end
          }
        end
      else
        flash[:error] = populator.errors.full_messages.join(" ")
        redirect_back_or_default(spree.root_path)
      end
    end
end