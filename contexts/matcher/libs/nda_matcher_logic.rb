module Matcher
  module Libs
    class NdaMatcherLogic
      include Dry::Monads[:result]

      include Import[
        toy_repo: 'contexts.matcher.repositories.cat_toy'
      ]

      def call(account:, order:)
        # some logic process payment in specific payment provider

        Success([])
      end
    end
  end
end
