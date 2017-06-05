[![Gem Version](https://badge.fury.io/rb/twilio_mock.svg)](https://badge.fury.io/rb/twilio_mock)
[![Build Status](https://travis-ci.org/MaicolBen/twilio_mock.svg?branch=master)](https://travis-ci.org/MaicolBen/twilio_mock)
![Code Quality](http://img.shields.io/codeclimate/github/MaicolBen/twilio_mock.svg)

# twilio_mock

It is a mocking library for the [twilio-ruby](https://github.com/twilio/twilio-ruby) gem. It covers buy numbers, sms and lookup for numbers.

## Installation

To install using [Bundler][bundler]:

```ruby
gem 'twilio_mock'
```

To manually install `twilio_mock`:

```bash
gem install twilio_mock
```

## Includes

 * Send SMS/MMS (`client.messages.create`)
 * Get a new number (`client.available_phone_numbers`)
 * Buy a number (`client.incoming_phone_numbers.create`)
 * Lookup Phone Number information (`lookups_client.phone_numbers.get`)

## Manual mock

By default the mocking is enabled, but you can disable it and call the mocker with your own parameters:

```ruby
TwilioMock::Testing.disable!

attrs = {
  from: 'from_number',
  to: 'to_number',
  body: 'text message',
}
TwilioMock::Mocker.new.create_message(attrs)
client.messages.create(attrs)

TwilioMock::Testing.enable!

# or with a block
TwilioMock::Testing.disable! do
  TwilioMock::Mocker.new.available_number(my_number)
  number = account.available_phone_numbers.get('US').local.list.first.phone_number
  my_number == number # true
  attrs = {
    phone_number: my_number,
    sms_url: 'my sms callback',
    sms_method: 'POST'
  }
  TwilioMock::Mocker.new.buy_number(attrs)

  account.incoming_phone_numbers.create(
    phone_number: phone_number,
    sms_url: sms_url,
    sms_method: 'POST'
  )
end
```
