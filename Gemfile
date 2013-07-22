source 'https://rubygems.org'

gem 'authlogic'
gem 'aws-s3'
gem 'aws-sdk'
gem 'exception_notification', git: 'git://github.com/alanjds/exception_notification.git'
gem 'haml-rails'
gem 'jquery-rails'
gem 'mysql2'
gem 'paperclip'
gem 'paperclip-s3'
gem 'rails', '3.2.13'
gem 'rvm-capistrano'

group :assets do
  gem 'bootstrap-sass'
  gem 'coffee-rails'
  gem 'font-awesome-sass-rails'
  gem 'sass-rails'
  gem 'uglifier'
end

group :development, :test do
  gem 'capistrano_colors'
  gem 'capistrano-ext'
  gem 'guard-rspec'
  gem 'jasmine'
  gem 'pry'
  gem 'spork'
  gem 'thin'
end

group :production, :staging do
  gem 'unicorn'
end

group :test do
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end