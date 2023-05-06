require 'simplecov'
if ENV['CI']
  SimpleCov.start
end

require 'bundler/setup'
require 'webmock/rspec'
require './lib/twilio_mock'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    TwilioMock::Testing.enable!
  end

  config.after(:each) do
    TwilioMock::Mocker.new.clean
  end
end
