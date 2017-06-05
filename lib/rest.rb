require 'twilio-ruby'

module Twilio
  module REST
    class Messages < ListResource
      def create(attrs)
        TwilioMock::Mocker.new.create_message(attrs) if TwilioMock::Testing.enabled?
        super(attrs)
      end
    end

    class IncomingPhoneNumbers < ListResource
      def create(attrs)
        TwilioMock::Mocker.new.buy_number(attrs) if TwilioMock::Testing.enabled?
        super(attrs)
      end
    end

    class AvailablePhoneNumbers < ListResource
      def get(sid)
        TwilioMock::Mocker.new.available_number if TwilioMock::Testing.enabled?
        super(sid)
      end
    end

    module Lookups
      class PhoneNumbers < NextGenListResource
        def get(number)
          TwilioMock::LookupMocker.new.lookup(number) if TwilioMock::Testing.enabled?
          super(number)
        end
      end
    end
  end
end
