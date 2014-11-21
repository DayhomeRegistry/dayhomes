module ProductExtensions

  def plan
    self.preferred_plan
  end
  def is_subscription?
    has_valid_plan?
  end

  protected
    def has_valid_plan?
      true
    end
end

Spree::Product.class_eval do
  prepend ProductExtensions

  preference :plan, :string
end