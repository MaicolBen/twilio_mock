module TwilioExtensions
  module AccountContext
    def available_phone_numbers(country_code=:unset)
      client = @version.instance_variable_get(:@domain).client
      TwilioMock::Mocker.new(username: client.account_sid, token: client.auth_token).available_number if TwilioMock::Testing.enabled?
      super(country_code)
    end
  end

  module AvailablePhoneNumberContext
    def list(area_code: :unset, contains: :unset, sms_enabled: :unset, mms_enabled: :unset, voice_enabled: :unset, exclude_all_address_required: :unset, exclude_local_address_required: :unset, exclude_foreign_address_required: :unset, beta: :unset, near_number: :unset, near_lat_long: :unset, distance: :unset, in_postal_code: :unset, in_region: :unset, in_rate_center: :unset, in_lata: :unset, in_locality: :unset, limit: nil, page_size: nil)
      client = @version.instance_variable_get(:@domain).client
      params = {}
      params[:area_code] = area_code unless area_code == :unset
      TwilioMock::Mocker.new(username: client.account_sid, token: client.auth_token).available_number_list(params) if TwilioMock::Testing.enabled?
      super
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
