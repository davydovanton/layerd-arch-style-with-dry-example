module Shop
  module Commands
    class AddItemsToOrder
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      include Import[
        order_repo: 'contexts.shop.repositories.order'
      ]

      ItemValidator = Dry::Schema.Params do
        required(:items).array(:array, min_size?: 1) do
          required(:title).value(Shop::Types::ItemTitle)
          required(:count).value(Shop::Types::ItemCount)
        end
      end

      def call(order_id:, account_id:, items:)
        items = yield validate_items(items)

        order = yield find_order(account_id, order_id)
        order = yield add_items_to_order(order, items)

        Success(order: order)
      end

    private

      def validate_items(items)
        ItemValidator.call(items: items).to_monad
          .fmap { |result| result[:items] }
          .or   { |result| Failure([:invalid_items, { error_message: result.to_h, original_items: items }]) }
      end

      def find_order(account_id, order_id)
        # use try monad for detect DB exeption. If detected - creating a new Failure object by #or method
        Try[RecordNotFoundDbExeption] do
          order_repo.find_or_create(account_id: account_id, order_id: order_id)
        end.to_result.or(
          Failure([:order_and_account_not_founded, { account_id: account_id, order_id: order_id}])
        )
      end

      def add_items_to_order(order, items)
        # You can create #add_items_to_order method for repository. It's just fictional example.
        # I just use this way to show how to do something like this

        items.each do |item|
          order_repo.add_item(order_id: order.id, title: item[:title], count: item[:count])
        end

        Success(order_repo.find(id: order.id))
      end
    end
  end
end
