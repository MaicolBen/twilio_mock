module TwilioMock
  class LookupMocker < Mocker
    API_VERSION = 'v1'.freeze
    HOST = 'lookups.twilio.com'.freeze

    def lookup(number, country_code = nil)
      stub_request(:get, "#{base_twilio_url}/PhoneNumbers/#{number}")
        .to_return(status: 200, body: response(number, country_code), headers: {})
    end

    private

    def response(number, country_code)
      {
        country_code: country_code || 'US',
        phone_number: number,
        url: "#{base_twilio_url}/PhoneNumber/number"
      }.to_json
    end

    def base_twilio_url
      "https://#{HOST}/#{API_VERSION}"
    end
  end
end
