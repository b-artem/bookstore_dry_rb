# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bookstore
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults '6.0'

    # Settings in config/environments/* take precedence over those specified here.
    # Don't generate system test files.
    config.generators.system_tests = nil

    config.generators do |g|
      g.test_framework :rspec
    end

    config.i18n.default_locale = :en

    # https://guides.rubyonrails.org/autoloading_and_reloading_constants.html#%24load-path
    config.add_autoload_paths_to_load_path = false

    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
