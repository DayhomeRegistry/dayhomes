Spree::CheckoutController.class_eval do
  # New state
  def before_subscriptions
    if try_spree_current_user && try_spree_current_user.respond_to?(:payment_sources)
      @payment_sources = try_spree_current_user.payment_sources
    end
  end
end