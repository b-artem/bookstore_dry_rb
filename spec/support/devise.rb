# require 'rspec/rails'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers#, :type => :controller
  # config.extend ControllerMacros, :type => :controller
  # config.include Devise::Test::IntegrationHelpers#, type: :feature

end
