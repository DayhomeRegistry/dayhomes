Deface::Override.new(:virtual_path => "spree/checkout/payment/_paypal",
					 :name => 'change_paypal_url',
					 :replace_contents => "erb[loud]:contains('paypal_express_url')",
					 :text => 'link_to(image_tag(!@order.has_subscription? ? "https://www.paypal.com/en_US/i/btn/btn_xpressCheckout.gif" : "https://www.paypalobjects.com/en_US/i/btn/btn_subscribe_LG.gif"), (!@order.has_subscription? ? paypal_express_url(:payment_method_id => payment_method.id) : paypal_subscription_url(:payment_method_id => payment_method.id)), :method => :post, :id => "paypal_button")',
					 :original => '24b1e7a9f61c085d382a8f2ba47bb701a24f370e') 

