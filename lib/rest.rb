require 'twilio-ruby'
require 'twilio_extensions'

module Twilio
  module REST
    class Api < Domain
      class V2010 < Version
        class AccountContext < InstanceContext
          prepend TwilioExtensions::AccountContext

          class MessageList < ListResource
            prepend TwilioExtensions::Messages
          end

          class IncomingPhoneNumberList < ListResource
            prepend TwilioExtensions::IncomingPhoneNumbers
          end
        end
      end
    end

    class Lookups
      class V1 < Version
        class PhoneNumberContext < InstanceContext
          prepend TwilioExtensions::Lookups
        end
      end
    end
  end
end
