require "selenium/webdriver"
require 'capybara/rspec'

Capybara.register_driver :selenium_chrome_in_container do |app|
  Capybara::Selenium::Driver.new app,
                                 browser: :remote,
                                 url: "http://selenium_chrome:4444/wd/hub",
                                 desired_capabilities: :chrome
end

Capybara.register_driver :headless_selenium_chrome_in_container do |app|
  Capybara::Selenium::Driver.new app,
                                 browser: :remote,
                                 url: "http://selenium_chrome:4444/wd/hub",
                                 desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
                                     chromeOptions: { args: %w(headless disable-gpu)}
                                 )
end

Capybara.server_host = "0.0.0.0"
Capybara.server_port = 4000
Capybara.app_host = 'http://web:4000'
Capybara.javascript_driver = :selenium_chrome_in_container

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    if config.use_transactional_fixtures?
      raise(<<-MSG)
        Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
        (or set it to false) to prevent uncommitted transactions being used in
        JavaScript-dependent specs.

        During testing, the app-under-test that the browser driver connects to
        uses a different database connection to the database connection used by
        the spec. The app's database connection would not be able to access
        uncommitted transaction data setup over the spec's database connection.
      MSG
    end
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  # config.before(:each, type: :feature, js: true) do
    # driven_by :selenium_chrome_in_container
    # Capybara.javascript_driver = :selenium_chrome_in_container
    # Capybara.server_host = "0.0.0.0"
    # Capybara.server_port = 4000
    # Capybara.app_host = 'http://web:4000'
  # end

  config.before(:each, type: :feature) do
    # :rack_test driver's Rack app under test shares database connection
    # with the specs, so continue to use transaction strategy for speed.
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

    unless driver_shares_db_connection_with_specs
      # Driver is probably for an external browser with an app
      # under test that does *not* share a database connection with the
      # specs, so use truncation strategy.
      DatabaseCleaner.strategy = :truncation
    end
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end

end