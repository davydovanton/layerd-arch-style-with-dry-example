module Shop
  module Repositories
    class Account
      include Import[db: 'persistance.db']

      def create(name: nil, email:, address:)
        id = db.execute(%{
          INSERT INTO accounts (name, email, address) VALUES (?, ?, ?) RETURNING id
        }, name, email, address).first['id']

        find(id: id)
      end

      def find(id:)
        map_raw_result_to_entity(
          db.execute("SELECT * FROM accounts WHERE id=?", id).first
        )
      end

    private

      def map_raw_result_to_entity(raw_account)
        Shop::Entities::Account.new(raw_account)
      end
    end
  end
end
