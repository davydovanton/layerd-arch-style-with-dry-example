module Matcher
  module Commands
    class SelectCatToysForOrder
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      include Import[
        nda_matcher_logic: 'contexts.matcher.libs.nda_matcher_logic',
        account_repo: 'contexts.matcher.repositories.account',
      ]

      # optional: you can use separate file and inject schema as DI
      OrderSchemaValidator = Dry::Schema.Params do
        required(:status).value(eql?: 'payed')

        required(:items).array(:hash, min_size?: 1) do
          required(:title).value(Matcher::Types::String)
          required(:count).value(Matcher::Types::Integer)
        end
      end

      def call(payload)
        order = yield validate_order(payload[:order])
        account = yield find_account(payload[:account_id])

        selected_toys = yield nda_matcher_logic.call(account: account, order: order)

        Success(selected_toys: selected_toys)
      end

    private

      def validate_order(order)
        OrderSchemaValidator.call(order).to_monad
          .fmap { |result| result.to_h }
          .or   { |result| Failure([:invalid_order, { error_message: result.errors.to_h, original_order: order }]) }
      end

      def find_account(account_id)
        account = account_repo.find(id: account_id)

        if account
          Success(account)
        else
          Failure([:account_not_founded, { account_id: account_id, account: account}])
        end
      end
    end
  end
end
