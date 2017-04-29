RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
require 'capybara/rspec'
require 'database_cleaner'
require 'webmock/rspec'
require 'capybara/poltergeist'
require 'billy/capybara/rspec'

# in spec/support/ and its subdirectories.
Dir[File.dirname(__FILE__) + ("/support/**/*.rb")].each {|f| require f}

Capybara.javascript_driver = :poltergeist_billy


Capybara.app = CobotFb.tap { |app|  }


# Capybara.configure do |config|
#   config.match = :one
#   config.exact_options = true
#   config.ignore_hidden_elements = true
#   config.visible_text_only = true
# end

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end

def stub_fb_auth
  fake = Koala::Facebook::OAuth.new('fb_app_id', 'fb_app_key')
  Koala::Facebook::OAuth.stub(new: fake)
  fake
end
