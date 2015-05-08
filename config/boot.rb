# Defines our constants
PADRINO_ENV  = ENV["PADRINO_ENV"] ||= ENV["RACK_ENV"] ||= "development"  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, PADRINO_ENV)
require 'raven'

##
# Enable devel logging
Padrino::Logger::Config[:development] = { :log_level => :debug, :stream => :to_file }
Padrino::Logger::Config[:test] = { :log_level => :debug, :stream => :to_file }
Padrino::Logger::Config[:production] = { :log_level => :error, :stream => :stdout }
#
# Padrino::Logger::Config[:development] = { :log_level => :devel, :stream => :stdout }
# Padrino::Logger.log_static = true
#
Raven.configure do |config|
  config.dsn = 'https://f0f9204d5b68407aae2a8f9b298b09be:b42e23a08f894a569934df4c9265e728@app.getsentry.com/9873'
end

##
# Add your before load hooks here
#
Padrino.before_load do
end

##
# Add your after load hooks here
#
Padrino.after_load do
end

Padrino.load!
