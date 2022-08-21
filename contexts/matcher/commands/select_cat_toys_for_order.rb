module Matcher
  module Commands
    class SelectCatToysForOrder
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      include Import[
        account_repo: 'contexts.matcher.repositories.account',
        toy_repo: 'contexts.matcher.repositories.cat_toy',
      ]

      OrderValidator = Dry::Schema.Params do
        required(:status).value(eql?: 'payed')

        required(:items).array(:array, min_size?: 1) do
          required(:title).value(matcher::Types::String)
          required(:count).value(matcher::Types::Integer)
        end
      end

      def call(account_id:, order:)
        order = yield validate_order(order)
        account = yield find_account(account_id)

        selected_toys = yield nda_matcher_logic.call(account: account, order: order)

        Success(selected_toys: selected_toys)
      end

    private

      def validate_order(order)
        OrderValidator.call(order).to_monad
          .or   { |result| Failure([:invalid_order, { error_message: result.to_h, original_order: order }]) }
      end

      def find_account(account_id)
        account = account_repo.find(id: account_id),

        if account
          Success(account: account, order: order)
        else
          Failure([:account_not_founded, { account_id: account_id, account: account}])
        end
      end
    end
  end
end
