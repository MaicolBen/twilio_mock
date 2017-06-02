class TwilioNumberGenerator
  include Singleton

  BASE_TEST_NUMBER = '+1500555'.freeze

  attr_reader :available_numbers

  def initialize
    @available_numbers = []
  end

  def generate
    number = loop do
      number = "#{BASE_TEST_NUMBER}#{rand(9999).to_s.rjust(4, '0')}"
      unless @available_numbers.include?(number)
        @available_numbers << number
        break number
      end
    end
  end
end
