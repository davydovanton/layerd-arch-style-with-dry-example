module Shop
  module Repositories
    class Order
      include Import[db: 'persistance.db']

      def create(account_id:)
        id = db.execute(%{
          INSERT INTO orders (account_id) VALUES (?) RETURNING id
        }, account_id).first['id']

        find(id: id)
      end

      def find(id:)
        db.transaction
        raw_order = db.execute('SELECT * FROM orders WHERE id=?', id).first
        raw_items = db.execute('SELECT * FROM items WHERE order_id=?', id)
        db.commit

        map_raw_result_to_entity({ **raw_order, items: raw_items })
      end

      def add_item(order_id:, title:, count:)
        db.execute(%{
          INSERT INTO items (order_id, title, count) VALUES (?, ?, ?)
        }, order_id, title, count)

        find(id: order_id)
      end

      def change_status(id:, status:)
        db.execute(%{
          UPDATE orders
          SET status=?
          WHERE id=?
        }, status, id)

        find(id: id)
      end

    private

      def map_raw_result_to_entity(raw_order)
        Shop::Entities::Order.new(raw_order)
      end
    end
  end
end
