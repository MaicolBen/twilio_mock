[![Gem Version](https://badge.fury.io/rb/twilio_mock.svg)](https://badge.fury.io/rb/twilio_mock)
[![Build Status](https://travis-ci.org/MaicolBen/twilio_mock.svg?branch=master)](https://travis-ci.org/MaicolBen/twilio_mock)
[![Code Climate](https://codeclimate.com/github/MaicolBen/twilio_mock/badges/gpa.svg)](https://codeclimate.com/github/MaicolBen/twilio_mock)
[![Test Coverage](https://codeclimate.com/github/MaicolBen/twilio_mock/badges/coverage.svg)](https://codeclimate.com/github/MaicolBen/twilio_mock/coverage)
[![Downloads](https://img.shields.io/gem/dt/twilio_mock.svg)](https://rubygems.org/gems/twilio_mock)
[![Issues](https://img.shields.io/github/issues/Maicolben/twilio_mock.svg?style=flat-square)](https://github.com/vcr/vcr/issues)

# twilio_mock

It is a mocking library for the [twilio-ruby](https://github.com/twilio/twilio-ruby) gem. It covers buy numbers, sms and lookup for numbers. It needs Ruby >= 2.2.
Which version of `twilio-ruby` do you have?
 - 3: use 0.2.0 version
 - 4: use 0.3.0 version
 - 5: use 0.4.0 version

## Installation

To install using bundler:

```ruby
gem 'twilio_mock'
```

To manually install `twilio_mock`:

```bash
gem install twilio_mock
```

## Includes

 * Send SMS/MMS (`account.messages.create`)
 * Get a new number (`account.available_phone_numbers`)
 * Buy a number (`account.incoming_phone_numbers.create`)
 * Lookup Phone Number information (`client.lookups.v1.phone_numbers`)

## Setup

Add `require 'twilio_mock'` to the `spec_helper.rb`, and if you want to inspect the messages sent:

```ruby
config.after(:each) do
  TwilioMock::Mocker.new.clean
end
```

## Manual mock

By default the mocking is enabled, but you can disable it and call the mocker with your own parameters:

### Sending messages

```ruby
TwilioMock::Testing.disable!
mocker = TwilioMock::Mocker.new
attrs = {
  from: 'from_number',
  to: 'to_number',
  body: 'text message',
}
mocker.create_message(attrs)
account.messages.create(attrs)

mocker.messages.last # here is your message sent

TwilioMock::Testing.enable!

```

### Buying numbers

```ruby
TwilioMock::Testing.disable! do
  mocker = TwilioMock::Mocker.new
  mocker.available_number(my_number)
  number = account.available_phone_numbers.get('US').local.list.first.phone_number
  my_number == number # true
  attrs = {
    phone_number: my_number,
    sms_url: 'my sms callback',
    sms_method: 'POST'
  }
  mocker.buy_number(attrs)

  account.incoming_phone_numbers.create(
    phone_number: phone_number,
    sms_url: sms_url,
    sms_method: 'POST'
  )
end
```
