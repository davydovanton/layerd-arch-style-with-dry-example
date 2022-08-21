module Shop
  module Queries
    class ShowOrder
      include Dry::Monads[:result]

      include Import[
        account_repo: 'contexts.shop.repositories.account',
        order_repo: 'contexts.shop.repositories.order',
      ]

      def call(account_id:, order_id:)
        account = account_repo.find(id: account_id),
        order = order_repo.find(id: order_id)

        if account && order
          Success(account: account, order: order)
        else
          Failure(
            [
              :order_and_account_not_finded,
              { account_id: account_id, account: account, order_id: order_id, order: order}
            ]
          )
        end
      end
    end
  end
end
