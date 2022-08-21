module Shop
  module Entities
    class Item < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, Shop::Types::Integer
      attribute :order_id, Shop::Types::Integer

      attribute :title, Shop::Types::ItemTitle
      attribute :count, Shop::Types::ItemCount
    end
  end
end
