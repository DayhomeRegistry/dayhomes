source 'https://rubygems.org'

gem 'rails',                  '3.2.1'

gem 'jquery-rails'

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
  gem 'sqlite3'
  gem 'capistrano-fanfare'
end

group :production do
  gem 'mysql2'
end
