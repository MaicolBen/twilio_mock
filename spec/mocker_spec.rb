require 'spec_helper'

RSpec.describe TwilioMock::Mocker do
  let(:client) { Twilio::REST::Client.new }
  let(:available_numbers) { client.account.available_phone_numbers.get('US').local.list({}) }
  let(:first_available_number) { available_numbers.first.phone_number }
  let(:sms_url) { 'test.host/callback' }

  describe 'get available phone number' do
    it 'returns a test number' do
      expect(first_available_number).to match(/150055/)
    end
  end

  describe 'buy a number' do
    it 'calls the incoming api' do
      expect_any_instance_of(Twilio::REST::IncomingPhoneNumbers).to receive(:create)

      client.account.incoming_phone_numbers.create(
        phone_number: first_available_number,
        sms_url: sms_url,
        sms_method: 'POST'
      )
    end
  end

  describe 'sends a sms' do
    it 'calls the message api' do
      expect_any_instance_of(Twilio::REST::Messages).to receive(:create)

      client.account.messages.create({
        from: first_available_number,
        to: '+15005550003',
        body: 'Example'
      })
    end
  end
end
