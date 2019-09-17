# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.4.7'

# Server requirements (defaults to WEBrick)
gem 'unicorn'
# gem 'mongrel'

# Project requirements
gem 'koala'
gem 'nokogiri', '>= 1.10.4'
gem 'oauth2'
gem 'rack', '>= 1.6.11'
gem 'rake'
gem 'sentry-raven'

# Component requirements
gem 'activerecord', '~> 4.0', require: 'active_record'
gem 'erubis'
gem 'pg'

# Test requirements
group 'test' do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'em-http-request', '1.1.3'
  gem 'launchy'
  gem 'poltergeist'
  gem 'puffing-billy'
  gem 'rack-test', require: 'rack/test'
  gem 'rspec'
  gem 'webmock'
end

group 'development' do
  gem 'foreman'
end

# Padrino Stable Gem
gem 'padrino', '0.12.9'
gem 'tilt'
