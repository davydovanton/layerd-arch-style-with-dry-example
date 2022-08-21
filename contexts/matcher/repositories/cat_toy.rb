module Matcher
  module Repositories
    class CatToy
      include Import[db: 'persistance.db']

      def all_active
        db.execute("SELECT * FROM cat_toys WHERE archived = 0")
          .map { |raw_toy| Matcher::Entities::CatToy.new(raw_toy) }
      end

      # only for local development propouse
      def create(title:, characteristic:, archived: 0)
        db.execute(%{
          INSERT INTO cat_toys(title, characteristic, archived) VALUES (?, ?, ?) RETURNING id
        }, title, characteristic, archived)
      end
    end
  end
end
