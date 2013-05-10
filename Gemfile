source 'http://rubygems.org'

gem 'rails', '3.2.2'
gem 'mysql2'
gem 'haml'
#gem 'gmaps4rails', :git => 'git@github.com:RyanonRails/Google-Maps-for-Rails.git'
gem 'gmaps4rails','1.4.8'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'carmen'
gem 'authlogic'
gem 'kaminari'
gem 'awesome_print'
#gem 'carrierwave', :git => 'git://github.com/jnicklas/carrierwave.git'
gem 'carrierwave'
gem 'mini_magick'
gem 'fog'
gem 'jquery-star-rating-rails'
gem 'forum_monster'
gem 'bb-ruby'
gem 'koala'
#gem 'airbrake'
gem 'exception_notification', :git => 'git://github.com/DayhomeRegistry/exception_notification.git'
gem 'maruku'
gem 'simple_form'
gem 'client_side_validations' , '~> 3.2', :git => 'https://github.com/bcardarella/client_side_validations.git'
gem 'actionmailer-instyle', :require => 'action_mailer/in_style'
gem 'stripe'
gem 'thin', '~>1.5'
gem 'foreigner'
gem 'ruby-recaptcha'
gem 'execjs'

platforms :mswin, :mingw do
  #gem 'eventmachine', '1.0.0.beta.4.1'
  #gem 'eventmachine', :git=> 'git://github.com/eventmachine/eventmachine.git'
  #gem 'thin'
end

group :assets do
  gem 'sass-rails', '~> 3.1'
  gem 'bootstrap-sass', '~> 2.0.2'

  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
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
end

group :production do
  # app server and process management
  gem 'unicorn'
  gem 'foreman', '0.47.0'
  gem 'therubyracer'
end
