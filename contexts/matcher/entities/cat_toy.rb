module Matcher
  module Entities
    class CatToy < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, Matcher::Types::Integer

      attribute :title, Matcher::Types::CatToyTitle
      attribute :characteristic, Matcher::Types::CatToyCharacteristic
      attribute :archived, Matcher::Types::CatToyArchivedStatus

      def archived?
        self.archived
      end
    end
  end
end
