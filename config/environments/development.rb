Dayhomes::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # See everything in the log (default is :info) 
  config.log_level = :debug
  
  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = {:host =>"localhost:3000"}  
  config.action_mailer.asset_host='http://staging.dayhomeregistry.com'
  #ActionMailer::Base.asset_host= 'http://staging.dayhomeregistry.com'
  ActionMailer::Base.smtp_settings = {
    #:tls => true,
    :address => "smtp.gmail.com",
    :port => "587",
    :domain => "dayhomeregistry.com",
    :authentication => :plain,
    :user_name => "staging@dayhomeregistry.com",
    :password => "bl@nk4n0w",
	:enable_starttls_auto =>true,
	:openssl_verify_mode=>OpenSSL::SSL::VERIFY_NONE
  }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  # config.active_record.mass_assignment_sanitizer = :strict
  config.active_record.raise_in_transactional_callbacks = true

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
  #config.assets.precompile += %w(jquery.home_slider.js upgrade.js upgrade_init.js billing.js billing_init.js organization.js categories.css mailer.css pages.css landingpage.css landingpage.js searches.js searches.css)


  #Preloader
  config.eager_load=false

end
