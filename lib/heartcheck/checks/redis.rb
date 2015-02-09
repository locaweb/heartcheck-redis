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
          con = service[:connection]

          unless (con.set 'check_test', 'heartcheck') == 'OK'
            append_error(service, :set)
          end
          unless (con.get 'check_test') == 'heartcheck'
            append_error(service, :get)
          end
          append_error(service, :delete) unless (con.del 'check_test') == 1
        end
      end

      private

      # customize the error message
      # It's called in Heartcheck::Checks::Base#append_error
      #
      # @param service [Hash]
      # @option params [String] :name A identifier of service
      # @param key_error [Symbol] name of action
      #
      # @return [void]
      def custom_error(service, key_error)
        @errors << "#{service[:name]} fails to #{key_error}"
      end
    end
  end
end
