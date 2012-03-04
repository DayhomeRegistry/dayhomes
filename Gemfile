source 'https://rubygems.org'

gem 'jquery-rails'
gem 'mysql2'
gem 'rails', '3.2.2'

# app server and process management
gem 'unicorn'
gem 'foreman'

group :assets do
  gem 'sass-rails', '~> 3.1'
  gem 'bootstrap-sass', '~> 2.0.1'

  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'capistrano-fanfare'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'rspec-rails', '~> 2.6'
  gem 'webrat', '~> 0.7.3'
end

group :production do
  # No production only gems right now
end
