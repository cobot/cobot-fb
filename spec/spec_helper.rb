PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
require 'capybara/rspec'

Capybara.app = CobotFb

def app
  ##
  # You can handle all padrino applications using instead:
  #   Padrino.application
  CobotFb.tap { |app|  }
end

def stub_fb_auth
  fake = Koala::Facebook::OAuth.new('fb_app_id', 'fb_app_key')
  Koala::Facebook::OAuth.stub(new: fake)
  fake
end

def stub_cobot_auth
end
