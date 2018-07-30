require 'spec_helper'

RSpec.describe TwilioMock::Mocker do
  let(:client) { Twilio::REST::Client.new('example', 'example') }
  let(:available_numbers) { client.api.account.available_phone_numbers('US').local.list({}) }
  let(:first_available_number) { available_numbers.first.phone_number }
  let(:sms_url) { 'test.host/callback' }

  describe 'get available phone number' do
    it 'returns a test number' do
      expect(first_available_number).to match(/150055/)
    end

    context "with area code" do
      let(:available_numbers) { client.api.account.available_phone_numbers('US').local.list(area_code: "123") }

      it 'returns a test number with the correct area code' do
        expect(first_available_number).to match(/112355/)
      end
    end
  end

  describe 'buy a number' do
    it 'calls the incoming api' do
      expect_any_instance_of(TwilioExtensions::IncomingPhoneNumbers).to receive(:create)

      client.api.account.incoming_phone_numbers.create(
        phone_number: first_available_number,
        sms_url: sms_url,
        sms_method: 'POST'
      )
    end
  end

  describe 'sends a sms' do
    let(:from) { first_available_number }
    let(:to)   { '+15005550003' }
    let(:body) { 'Example' }
    let(:params) do
      {
        from: from,
        to: to,
        body: body
      }
    end

    it 'calls the message creation' do
      expect_any_instance_of(TwilioExtensions::Messages).to receive(:create)

      client.api.account.messages.create(params)
    end

    it 'adds to the messages queue' do
      client.api.account.messages.create(params)

      message = TwilioMock::Mocker.new.messages.last
      expect(message.from).to eq from
      expect(message.to).to eq to
      expect(message.body).to eq body
    end

    context 'two messages' do
      before do
        client.api.account.messages.create(params)
        client.api.account.messages.create(params)
      end

      it 'the queue has 2 elements' do
        expect(TwilioMock::Mocker.new.messages.count).to eq 2
      end
    end
  end
end
