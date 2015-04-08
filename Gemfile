source 'https://rubygems.org'
gem 'byebug'
gem 'rails' #, '4.1.6'
gem 'mysql2'
gem 'haml'


#This here is for authentication
gem 'simple_form', '~>3'
#gem 'protected_attributes'
gem 'devise', '>=3.4'
gem 'omniauth-facebook'

#Jquery assets
gem 'jquery-rails'
gem 'jquery-ui-rails'
#gem 'gmaps-autocomplete-rails'

#Image processing
gem 'carrierwave'
gem 'mini_magick'
gem 'fog' 

#This needs a hefty upgrade
gem 'gmaps4rails','1.4.8'

# This is used for the country/province select
gem 'carmen'
gem 'carmen-rails'

#Send errors to fogbugz
gem 'exception_notification', :git => 'git://github.com/DayhomeRegistry/exception_notification.git'

#Pagination
gem 'kaminari'
gem 'bootstrap-kaminari-views'

#You got it...stars
gem 'jquery-star-rating-rails'

#Markdown interpreter
gem 'maruku'

#Strip API for CCs
gem 'stripe'

#Recaptchs on contact forms
gem 'ruby-recaptcha'

#Runs JS in Ruby
gem 'execjs'

#Rack based handling of referral codes
gem 'rack-affiliates'
gem 'redcarpet'

#Geocoding
gem 'geokit'
gem 'geokit-rails'
gem 'geocoder'

#Performance monitoring
gem 'newrelic_rpm', '~> 3.8.0'

#Not sure what these were for
#gem 'forum_monster'
#gem 'bb-ruby'
gem 'premailer-rails'



platforms :mswin, :mingw do
  #gem 'eventmachine', '1.0.0.beta.4.1'
  #gem 'eventmachine', :git=> 'git://github.com/eventmachine/eventmachine.git'
  #gem 'thin'
end

group :assets do
  gem 'bootstrap-sass'#, '~> 3'
  gem 'sass-rails'#, '>= 3.2'
  gem 'autoprefixer-rails'

  gem 'coffee-rails'
  gem 'uglifier'
end

group :development, :test do
  gem 'foreigner'
  gem 'awesome_print'
  gem 'capistrano', '2.12.0'
  gem 'capistrano-fanfare', '0.0.21'
  gem 'rspec-rails', '~> 2.6'
  gem 'webrat', '~> 0.7.3'
  gem 'factory_girl_rails', :require => false
  gem 'shoulda-matchers'
  gem 'spork', '~> 1.0rc'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'thin', '~> 1.5'
  gem 'rack-mini-profiler'
  gem 'whiny_validation'
end

group :production do
  # app server and process management
  gem 'unicorn'
  gem 'unicorn-rails'
  gem 'foreman', '0.47.0'
  gem 'therubyracer'
end
