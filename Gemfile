source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }


#needed for ruby 3.0
#gem 'racc', '1.5.1' #needed for nokogiri version 1.5.2 is broken
#gem 'nio4r', '~> 2.0' #needed for actioncable version 2.5.7 is broken
#gem "mimemagic", "0.3.8" #mimemagic issue
# gem "nokogiri", "~> 1.10"
# gem 'record_tag_helper', '~> 1.0'
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'omniauth-auth0', '~> 2.5'
gem 'omniauth-rails_csrf_protection', '~> 0.1' 
gem 'composite_primary_keys', '>12.0'
# gem 'activesupport', '6.0.3.6'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

#composite_primary_keys version 13 isnt out and is required version to work with rails 6.1 
gem 'rails', '~> 6.1.3'
# gem 'rails', '< 6.1'
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
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '~> 1.4'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

group :production do
#use postgres on heroku instead of sqlite
  gem 'pg' 
  #for production storage
  gem "aws-sdk-s3", require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
