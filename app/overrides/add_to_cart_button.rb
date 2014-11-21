Deface::Override.new(:virtual_path => "spree/products/_cart_form",
					 :name => 'replace_add_to_cart_button',
					 :replace_contents => "erb[loud]:contains('add_to_cart')",
					 :text => "@product.is_subscription? ? Spree.t(:subscribe) : Spree.t(:add_to_cart)",
					 #:text => "WTF",
					 :original => '8208e945d6c9818e30ebaab1b37c1bd48eeb3b57' ) 