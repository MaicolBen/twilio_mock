module TwilioExtensions
  module AccountContext
    def available_phone_numbers(country_code=:unset)
      TwilioMock::Mocker.new.available_number if TwilioMock::Testing.enabled?
      super(country_code)
    end
  end

  module Messages
    def create(attrs)
      TwilioMock::Mocker.new.create_message(attrs) if TwilioMock::Testing.enabled?
      super(attrs)
    end
  end

  module IncomingPhoneNumbers
    def create(attrs)
      TwilioMock::Mocker.new.buy_number(attrs) if TwilioMock::Testing.enabled?
      super(attrs)
    end
  end

  module Lookups
    def fetch(*)
      TwilioMock::LookupMocker.new.lookup(@solution[:phone_number]) if TwilioMock::Testing.enabled?
      super
    end
  end
end
