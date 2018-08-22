require 'spec_helper'

RSpec.describe TwilioMock::LookupMocker do
  let(:client) { Twilio::REST::Client.new('example', 'example') }

  describe 'get country code from number' do
    it 'returns US' do
      expect(client.lookups.v1.phone_numbers('+15005550003').fetch().country_code).to eq 'US'
    end
  end
end
