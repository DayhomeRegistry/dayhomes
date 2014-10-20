# Deface::Override.new(:virtual_path   => 'spree/shared/_header',
#                      :name           => 'remove_header',
#                      :remove 		 => '#header'
# 					)
# Deface::Override.new(:virtual_path	 => 'spree/layouts/spree_application',
# 					 :name			 => 'add_header',
# 					 :insert_top	 =>	"[data-hook='body']",
#                      :partial		 => 'layouts/header'
#                     )
# Deface::Override.new(:virtual_path=> 'spree/layouts/spree_application',
# 					 :name			 => 'add_main_nav_bar',
# 					 :insert_top	 =>	"[data-hook='body'] div.container",
#                      :partial		 => 'spree/shared/main_nav_bar'
#                     )
# Deface::Override.new(:virtual_path   => 'spree/shared/_main_nav_bar',
#                      :name           => 'remove_home_link',
#                      :remove 		 => "#home-link erb[loud]:contains('link_to')"
# 					)