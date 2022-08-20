module InMemory
  module Transport
    class ShopRequest
      include Import[service: 'shop.service']

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
