require 'twilio-ruby'
require 'webmock'
require_relative 'number_generator'
require 'ostruct'

module TwilioMock
  class Mocker
    API_VERSION = '2010-04-01'.freeze
    HOST = 'api.twilio.com'.freeze

    def initialize
      @username = Twilio.account_sid
      @token = Twilio.auth_token
    end

    def create_message(attrs)
      messages_queue.add OpenStruct.new(attrs)
      prepare_stub(attrs, 'Messages.json')
    end

    def available_number(number = nil, params = nil)
      query_string = params && params.any? ? twilify(params).to_h.to_query : ''
      stub_request(:get, "#{base_twilio_url}/AvailablePhoneNumbers/US/Local.json?#{query_string}")
        .with(basic_auth: basic_auth)
        .to_return(status: 200, body: available_number_response(number), headers: {})
    end

    def buy_number(attrs)
      prepare_stub(attrs, 'IncomingPhoneNumbers.json')
    end

    def messages
      messages_queue.messages
    end

    def clean
      number_generator.clean
      messages_queue.clean
    end

    private

    def response
      {
        sid: @username
      }.to_json
    end

    def basic_auth
      [@username, @token]
    end

    def stub_request(method, url)
      WebMock.stub_request(method, url)
    end

    def base_twilio_url
      "https://#{HOST}/#{API_VERSION}/Accounts/#{@username}"
    end

    def prepare_stub(attrs, path)
      body = twilify(attrs).map { |k, val| [k, val.to_s] }.to_h
      stub_request(:post, "#{base_twilio_url}/#{path}")
        .with(body: body, basic_auth: basic_auth)
        .to_return(status: 200, body: response, headers: {})
    end

    def available_number_response(number)
      number ||= number_generator.generate
      {
        sid: @username,
        available_phone_numbers: [{ 'phone_number' => number }],
        meta: {
          key: 'available_phone_numbers'
        }
      }.to_json
    end

    def number_generator
      NumberGenerator.instance
    end

    def messages_queue
      MessagesQueue.instance
    end

    # extracted from the deprecated Twilio::REST::Utils
    def twilify(something)
      if something.is_a? Hash
        something = something.to_a
        something = something.map { |pair| [twilify(pair[0]).to_sym, pair[1]] }
        something = something.flatten(1)
        Hash[*something]
      else
        something.to_s.split('_').map! do |s|
          [s[0,1].capitalize, s[1..-1]].join
        end.join
      end
    end
  end
end
