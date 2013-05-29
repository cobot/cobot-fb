source 'https://rubygems.org'

# Server requirements (defaults to WEBrick)
gem 'unicorn'
# gem 'mongrel'

# Project requirements
gem 'rake'
gem 'sinatra-flash', :require => 'sinatra/flash'
gem 'koala'
gem 'oauth2'

# Component requirements
gem 'erubis'
gem 'activerecord', :require => "active_record"
gem 'pg'

# Test requirements
group "test" do
  gem 'rspec'
  gem 'rack-test', :require => "rack/test"
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'webmock'
end

group "development" do
  gem 'foreman'
end

# Padrino Stable Gem
gem 'padrino', '0.11.2'
gem 'tilt', '~> 1.3.0' #bundler dep resolution bug

