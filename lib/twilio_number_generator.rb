class TwilioNumberGenerator
  include Singleton

  attr_reader :available_numbers

  def initialize
    @available_numbers = []
  end

  def generate
    number = loop do
      number = "+15005551#{rand(999).to_s.rjust(3, '0')}"
      unless @available_numbers.include?(number)
        @available_numbers << number
        break number
      end
    end
  end
end
