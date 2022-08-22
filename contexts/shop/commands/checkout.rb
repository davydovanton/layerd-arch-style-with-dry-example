module Shop
  module Commands
    class Checkout
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      include Import[
        account_repo: 'contexts.shop.repositories.account',
        order_repo: 'contexts.shop.repositories.order',
        address_correctness_checker: 'contexts.shop.libs.address_correctness_checker',
        payment_provider_processing: 'contexts.shop.libs.payment_provider_processing',
      ]

      def call(order_id:, account_id:)
        account, order = yield find_account_and_order(account_id, order_id)

        yield validate_account(account)
        yield validate_order(order)

        payment_provider_result = yield address_correctness_checker.call(account, order)

        order = yield set_order_as_payed(order, payment_provider_result)

        Success(account: account, order: order)
      end

    private

      def find_account_and_order(account_id, order_id)
        account = account_repo.find(id: account_id),
        order = order_repo.find(id: order_id)

        if account && order
          Success(account: account, order: order)
        else
          Failure(
            [
              :order_and_account_not_founded,
              { account_id: account_id, account: account, order_id: order_id, order: order}
            ]
          )
        end
      end

      def validate_account(account)
        # some logic for detecting account address correctness

        return Failure([:invalid_account_email, { account: account }]) unless account.email.match?(/@/)

        account_address_correctness_checker.call(account)
      end

      def validate_order(account)
        return Failure([:order_empty, { order: order }]) if order.items.empty?
        return Failure([:order_already_payed, { order: order }]) if order.payed?

        order_status_check_result = Types::OrderOpenStatus.try(order.status).to_monad
        return Failure([:order_status_invalid, order_status_check_result.failure]) if order_status_check_result.failure?

        # etc ...
      end

      def call_payment_provider(account, order)

      end

      def set_order_as_payed(order, payment_provider_result)
        # Shop::Types::OrderPayedStatus[] -> hack for getting value of type
        Sucess(order_repo.change_status(id: order.id, status: Shop::Types::OrderPayedStatus[]))
      end
    end
  end
end
