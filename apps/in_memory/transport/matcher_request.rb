module InMemory
  module Transport
    class MatcherRequest
      include Import[service: 'contexts.matcher.service']

      def call
        puts 'Hello from in_memory matcher request'
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
