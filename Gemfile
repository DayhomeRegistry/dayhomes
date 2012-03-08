source 'https://rubygems.org'

gem 'rails', '3.2.2'
gem 'mysql2'
gem 'haml'
gem 'gmaps4rails'
gem 'jquery-rails'
gem 'mysql2'
gem 'carmen'

group :assets do
  gem 'sass-rails', '~> 3.1'
  gem 'bootstrap-sass', '~> 2.0.1'

  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'capistrano-fanfare'
  gem 'rspec-rails', '~> 2.6'
  gem 'webrat', '~> 0.7.3'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
end

group :production do
  # app server and process management
  gem 'unicorn'
  gem 'foreman'
end
