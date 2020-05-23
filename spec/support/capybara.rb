# frozen_string_literal: true

require 'support/wait_for_ajax'
require 'support/selenium_webdriver'
require 'support/capybara_screenshot'

ENV['HEADLESS'] ||= 'true'

Capybara.server = :puma, { Silent: true }

Capybara.register_driver :chrome do |app|
  opts = Selenium::WebDriver::Chrome::Options.new

  chrome_args = %w[--window-size=1920,1080]
  chrome_args.each { |arg| opts.add_argument(arg) }
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: opts)
end

Capybara.register_driver :headless_chrome do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(loggingPrefs: { browser: 'ALL' })
  opts = Selenium::WebDriver::Chrome::Options.new

  chrome_args = %w[--headless --no-sandbox --disable-gpu --window-size=1920,1080 --remote-debugging-port=9222]
  chrome_args.each { |arg| opts.add_argument(arg) }
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: opts, desired_capabilities: caps)
end

javascript_driver = ENV['HEADLESS'] == 'true' ? :headless_chrome : :chrome
Capybara.javascript_driver = javascript_driver
