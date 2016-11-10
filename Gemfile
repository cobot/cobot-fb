source 'https://rubygems.org'
ruby '2.2.2'

# Server requirements (defaults to WEBrick)
gem 'unicorn'
# gem 'mongrel'

# Project requirements
gem 'rake'
gem 'koala'
gem 'oauth2'
gem "sentry-raven", :git => "https://github.com/getsentry/raven-ruby.git"

# Component requirements
gem 'erubis'
gem 'activerecord', :require => "active_record"
gem 'pg'

# Test requirements
group "test" do
  gem 'rspec'
  gem 'rack-test', :require => "rack/test"
  gem 'poltergeist'
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'webmock'
end

group "development" do
  gem 'foreman'
end

# Padrino Stable Gem
gem 'padrino', '0.11.4'
gem 'tilt'

