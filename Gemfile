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
gem 'bootstrap-sass', '~> 3.4', '>= 3.4.1'
gem 'cancancan', '~> 2.0'
gem 'carrierwave', '~> 1.1'
gem 'coffee-rails', '~> 4.2'
gem 'country_select', '~> 3.1'
gem 'devise', '~> 4.7'
gem 'draper', '~> 3.0'
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'fog-aws', '~> 1.4', '>= 1.4.1'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.2'
gem 'haml-rails', '~> 1.0'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'kaminari', '~> 1.0', '>= 1.0.1'
gem 'mini_magick', '~> 4.9'
gem 'omniauth', '~> 1.9'
gem 'omniauth-facebook', '~> 4.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.12'
gem 'rails', '~> 5.1', '>= 5.1.7'
gem 'rails_admin', '1.3.0'
gem 'rails_admin_aasm', '~> 0.1.1'
gem 'sass-rails', '~> 5.0'
gem 'seed_dump', '~> 3.2', '>= 3.2.4'
gem 'simple_form', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'wicked', '~> 1.3', '>= 1.3.2'

group :development, :test do
  gem 'factory_girl_rails', '~> 4.8'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 3.5'
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
  gem 'rspec_junit_formatter', '~> 0.4.1'
  gem 'selenium-webdriver', '~> 3.142'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.2'
  gem 'simplecov', '~> 0.17.1', require: false
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
