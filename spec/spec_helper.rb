require 'bundler/setup'
require 'webmock/rspec'

Dir['./lib/**/*.rb'].each {|file| require file }

require './spec/twilio_config'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    TwilioMock::Testing.enable!
  end
end
