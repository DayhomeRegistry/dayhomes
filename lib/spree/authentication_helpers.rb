module Spree
  module AuthenticationHelpers
     def self.included(receiver)
       receiver.send :helper_method, :spree_login_path
       receiver.send :helper_method, :spree_signup_path
       receiver.send :helper_method, :spree_logout_path
       receiver.send :helper_method, :spree_current_user
     end

     def spree_current_user
       current_user
     end

     def spree_login_path
       main_app.login_path
     end

     def spree_signup_path
       main_app.signup_path
     end

     def spree_logout_path
       main_app.logout_path
     end
   end
end

Spree::BaseController.send      :include, Spree::AuthenticationHelpers
Spree::Api::BaseController.send :include, Spree::AuthenticationHelpers
ApplicationController.send      :include, Spree::AuthenticationHelpers