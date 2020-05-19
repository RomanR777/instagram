# frozen_string_literal: true
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.5.3'
# Use mongodb
gem 'mongoid', '~> 7.0.5'
# User redis for active cable
gem 'redis', '~> 4.1', '>= 4.1.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
gem 'devise'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'sidekiq', '~> 6.0', '>= 6.0.7'
gem 'sidekiq-cron', '~> 1.2'
gem 'actionview-encoded_mail_to'
gem 'kaminari', '~> 1.2'
gem 'bootstrap4-kaminari-views', '~> 1.0', '>= 1.0.1'

gem 'acts_as_follower', github: 'tcocca/acts_as_follower', branch: 'master'
gem 'active_record_union'

gem 'font-awesome-sass', '~> 5.12.0'
gem 'bootstrap', '~> 4.4.1'
gem 'jquery-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rspec-rails', '~> 4.0'
  gem 'factory_bot_rails', '~> 5.2'
  gem 'capybara', '~> 3.32', '>= 3.32.1'
  gem 'ffaker', '~> 2.14.0'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.4'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'database_cleaner', '~> 1.8', '>= 1.8.5'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
