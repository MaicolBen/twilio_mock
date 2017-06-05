module TwilioMock
  class Testing
    class << self
      attr_accessor :__test_mode

      def __set_test_mode(mode)
        if block_given?
          current_mode = self.__test_mode
          begin
            self.__test_mode = mode
            yield
          ensure
            self.__test_mode = current_mode
          end
        else
          self.__test_mode = mode
        end
      end

      def enable!(&block)
        __set_test_mode(:enable, &block)
      end

      def disable!(&block)
        __set_test_mode(:disable, &block)
      end

      def enabled?
        self.__test_mode == :enable
      end

      def disabled?
        self.__test_mode == :disable
      end
    end
  end
end

TwilioMock::Testing.enable! # default behavior
