module ProductExtensions
  # def update
  #   do_before_work
  #   super
  #   do_after_work
  # end
  def subscription?
    self.prefers_plan?
  end
  def plan
    self.preferred_plan
  end

  protected
  # def do_before_work
  #   # do something interesting before super
  # end
  # def do_after_work
  #   # do something interesting after super
  # end
end

Spree::Product.class_eval do
  prepend ProductExtensions

  preference :plan, :string
end