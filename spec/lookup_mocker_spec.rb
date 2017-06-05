require 'spec_helper'

RSpec.describe TwilioMock::LookupMocker do
  let(:client) { Twilio::REST::LookupsClient.new }

  describe 'get country code from number' do
    it 'returns US' do
      expect(client.phone_numbers.get('+15005550003').country_code).to eq 'US'
    end
  end
end
