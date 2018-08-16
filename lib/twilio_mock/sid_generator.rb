require 'singleton'

module TwilioMock
  class SidGenerator
    include Singleton

    def generate(prefix = "SM")
      "#{prefix}#{Digest::MD5.hexdigest(rand.to_s)}"
    end
  end
end
