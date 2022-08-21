module Shop
  module Entities
    class Item < Dry::Struct
      attribute :id, Shop::Types::Integer

      attribute :title, Shop::Types::ItemTitle
      attribute :count, Shop::Types::ItemCount
    end
  end
end
