require 'bundler/setup'
require './lib/rest'

Twilio.configure do |config|
  config.account_sid = 'example'
  config.auth_token = 'example'
end

require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)


RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  # config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
