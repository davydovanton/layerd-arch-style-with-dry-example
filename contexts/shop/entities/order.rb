module Shop
  module Entities
    class Order < Dry::Struct
      attribute :id, Shop::Types::Integer

      attribute :account, Account
      attribute :items, Types.Array(Item)
      attribute :status, Shop::Types::OrderStatuses
    end
  end
end
