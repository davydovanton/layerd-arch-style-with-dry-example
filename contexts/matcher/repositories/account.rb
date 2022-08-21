module Matcher
  module Repositories
    class Account
      include Import[db: 'persistance.db']

      def find(id:)
        map_raw_result_to_entity(
          db.execute("SELECT * FROM accounts WHERE id=?", id).first
        )
      end

    private

      def map_raw_result_to_entity(raw_account)
        Matcher::Entities::Account.new(raw_account)
      end
    end
  end
end
