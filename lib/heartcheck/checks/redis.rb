module Heartcheck
  module Checks
    # Check for a redis service
    # Base is set in heartcheck gem
    class Redis < Base
      # validate each service
      #
      # @retun [void]
      def validate
        services.each do |service|
          connection = service[:connection]

          append_error(service[:name], :set) unless set?(connection)
          append_error(service[:name], :get) unless get?(connection)
          append_error(service[:name], :delete) unless del?(connection)
        end
      end

      private

      # test if can write on redis
      #
      # @param con [Redis] an instance of redis
      #
      # @return [Bollean]
      def set?(con)
        con.set('check_test', 'heartcheck') == 'OK'
      end

      # test if can read on redis
      #
      # @param con [Redis] an instance of redis
      #
      # @return [Bollean]
      def get?(con)
        con.get('check_test') == 'heartcheck'
      end

      # test if can delete on redis
      #
      # @param con [Redis] an instance of redis
      #
      # @return [Bollean]
      def del?(con)
        con.del('check_test') == 1
      end

      # customize the error message
      # It's called in Heartcheck::Checks::Base#append_error
      #
      # @param name [String] An identifier of service
      # @param key_error [Symbol] name of action
      #
      # @return [void]
      def custom_error(name, key_error)
        @errors << "#{name} fails to #{key_error}"
      end
    end
  end
end
