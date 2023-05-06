module TwilioExtensions
  module AccountContext
    def available_phone_numbers(country_code = :unset)
      client = @version.instance_variable_get(:@domain).client
      TwilioMock::Mocker.new(username: client.account_sid, token: client.auth_token).available_number if TwilioMock::Testing.enabled?
      super(country_code)
    end
  end

  module Messages
    def create(attrs)
      client = @version.instance_variable_get(:@domain).client
      TwilioMock::Mocker.new(username: client.account_sid, token: client.auth_token).create_message(attrs) if TwilioMock::Testing.enabled?
      super(attrs)
    end
  end

  module IncomingPhoneNumbers
    def create(attrs)
      client = @version.instance_variable_get(:@domain).client
      TwilioMock::Mocker.new(username: client.account_sid, token: client.auth_token).buy_number(attrs) if TwilioMock::Testing.enabled?
      super(attrs)
    end
  end

  module Lookups
    def fetch(*)
      client = @version.instance_variable_get(:@domain).client
      TwilioMock::LookupMocker.new(username: client.account_sid, token: client.auth_token).lookup(@solution[:phone_number]) if TwilioMock::Testing.enabled?
      super
    end
  end
end
