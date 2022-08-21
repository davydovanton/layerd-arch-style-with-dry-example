module Matcher
  module Libs
    class NdaMatcherLogic
      include Dry::Monads[:result]


      def call(account:, order:)
        # some logic process payment in specific payment provider

        Success(:done)
      end
    end
  end
end
