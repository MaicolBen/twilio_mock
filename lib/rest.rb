require 'twilio-ruby'

module Twilio
  module REST
    class Messages < ListResource
      def create(attrs)
        TwilioMocker.new.stub_create_message(attrs)
        super(attrs)
      end
    end

    class IncomingPhoneNumbers < ListResource
      def create(attrs)
        TwilioMocker.new.stub_buy_number(attrs)
        super(attrs)
      end
    end

    class AvailablePhoneNumbers < ListResource
      def get(sid)
        TwilioMocker.new.stub_available_numbers
        super(sid)
      end
    end

    module Lookups
      class PhoneNumbers < NextGenListResource
        def get(number, query={})
          TwilioLookupMocker.new.stub_lookup(number)
          super(number, query)
        end
      end
    end
  end
end
