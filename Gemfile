# frozen_string_literal: true

ruby '2.6.6'

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# dry-rb libraries
gem 'dry-monads', '~> 1.3'
gem 'dry-schema', '~> 1.4'
gem 'dry-struct', '~> 1.2'
gem 'dry-transformer', '~> 0.1'
gem 'dry-types', '~> 1.2'
gem 'dry-validation', '~> 1.4'

gem 'aasm', '~> 4.12', '>= 4.12.2'
gem 'bootsnap', '~> 1.4', '>= 1.4.6'
gem 'bootstrap-sass', '~> 3.4', '>= 3.4.1'
gem 'cancancan', '~> 3.1'
gem 'country_select', '~> 3.1', '>= 3.1.1'
gem 'devise', '~> 4.7'
gem 'draper'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.2'
gem 'haml-rails'
gem 'jbuilder'
gem 'kaminari', '~> 1.2'
gem 'omniauth', '~> 1.9'
gem 'omniauth-facebook', '~> 4.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 4.3'
gem 'rails', '~> 6.0', '>= 6.0.3.2'
gem 'rails_admin'
gem 'rails_admin_aasm'
gem 'sass-rails', '~> 5.0'
gem 'simple_form', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'
gem 'wicked', '~> 1.3', '>= 1.3.2'

# Images
gem 'aws-sdk-s3', require: false
gem 'image_processing'

group :development, :test do
  gem 'factory_girl_rails', '~> 4.8'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'bundler-audit', '~> 0.6.1', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring', '~> 2.0', '>= 2.0.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '~> 2.13'
  gem 'capybara-screenshot'
  gem 'database_cleaner', '~> 1.6', '>= 1.6.1'
  gem 'faker', '~> 1.8', '>= 1.8.4'
  gem 'rack_session_access', '~> 0.1.1'
  gem 'rspec_junit_formatter'
  gem 'selenium-webdriver', '~> 3.142'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.2'
  gem 'simplecov', '~> 0.17.1', require: false
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
