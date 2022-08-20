module InMemory
  module Transport
    class ShopRequest
      include Import[service: 'contexts.shop.service']
      # include Import[service: 'contexts.matcher.service'] # Exeption example for cross context calls

      def call
        puts 'Hello from in_memory shop request'
        puts 'Call logic:'
        puts
        sleep 0.5

        service.call

        puts
        sleep 0.5
        puts 'Request done'
      end
    end
  end
end
