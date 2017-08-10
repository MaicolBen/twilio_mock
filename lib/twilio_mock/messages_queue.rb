require 'singleton'

module TwilioMock
  class MessagesQueue
    include Singleton

    attr_reader :messages

    def initialize
      @messages = []
    end

    def add(message)
      @messages << message
    end

    def clean
      @messages = []
    end
  end
end
