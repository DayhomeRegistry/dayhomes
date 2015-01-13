Spree::Order.class_eval do
  def after_subscribe(subscription)
  	byebug
  	
  	org = self.user.organization
  	org.plan = subscription.plan.variant.product.slug
  	org.save

  	if(org.individual?)
  		redirect_to beta_dayhome_overview_url(current_user.organization.day_homes.first) and return
  	else
  		redirect_to beta_plan_url
  	end
  end
end