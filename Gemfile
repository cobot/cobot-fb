source 'https://rubygems.org'
ruby '2.4.7'

# Server requirements (defaults to WEBrick)
gem 'unicorn'
# gem 'mongrel'

# Project requirements
gem 'rake'
gem 'koala'
gem 'oauth2'
gem "sentry-raven"

# Component requirements
gem 'erubis'
gem 'activerecord', '~> 4.0', :require => "active_record"
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
  gem 'puffing-billy'
  gem 'em-http-request', '1.1.3'
end

group "development" do
  gem 'foreman'
end

# Padrino Stable Gem
gem 'padrino', '0.12.5'
gem 'tilt'

