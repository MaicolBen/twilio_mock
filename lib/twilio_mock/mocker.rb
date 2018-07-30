require 'twilio-ruby'
require 'webmock'
require_relative 'number_generator'
require 'ostruct'
require_relative 'twilify'
require 'active_support'
require 'active_support/core_ext/object/to_query'

module TwilioMock
  class Mocker
    API_VERSION = '2010-04-01'.freeze
    HOST = 'api.twilio.com'.freeze

    def initialize(username: Twilio.account_sid, token: Twilio.auth_token)
      @username = username
      @token = token
    end

    def create_message(attrs)
      messages_queue.add OpenStruct.new(attrs)
      prepare_stub(attrs, 'Messages.json')
    end

    def available_number_list(params = nil)
      country_code = params.delete(:country_code)
      query_string = params && params.any? ? Twilify.process(params).to_h.to_query : ''
      stub_request(:get, "#{base_twilio_url}/AvailablePhoneNumbers/#{country_code}/Local.json?#{query_string}")
        .with(basic_auth: basic_auth)
        .to_return(status: 200, body: available_number_response(number_generator.generate(area_code: params[:area_code])), headers: {})
    end

    def buy_number(attrs)
      phone_number = attrs.with_indifferent_access[:phone_number]
      response = {
        account_sid: @username,
        sid: "PN#{Digest::MD5.hexdigest(phone_number)}",
        phone_number: phone_number
      }.to_json

      prepare_stub(attrs, 'IncomingPhoneNumbers.json', response: response)
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

    def prepare_stub(attrs, path, response: response)
      body = Twilify.process(attrs).map { |k, val| [k, val.to_s] }.to_h
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
  end
end
