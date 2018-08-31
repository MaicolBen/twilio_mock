require 'singleton'

module TwilioMock
  class NumberGenerator
    include Singleton

    BASE_TEST_NUMBER = '+1500555'.freeze

    attr_reader :available_numbers

    def initialize
      @available_numbers = []
    end

    def generate(area_code: nil)
      base = BASE_TEST_NUMBER if area_code.nil?
      base ||= "+1#{area_code}555"

      generate_number(base)
    end

    def clean
      @available_numbers = []
    end

    private
    def generate_number(base)
      number = loop do
        number = "#{base}#{rand(9999).to_s.rjust(4, '0')}"
        unless @available_numbers.include?(number)
          @available_numbers << number
          break number
        end
      end
    end
  end
end
