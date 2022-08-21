module Shop
  module Commands
    class Checkout
      # include Import[service: 'contexts.matcher.service'] # Exeption example for cross context calls

      def call(order_id:, account_id:)
        puts 'Calling shop context business logic'
      end
    end
  end
end
