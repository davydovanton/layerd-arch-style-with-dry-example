module Shop
  module Entities
    class Order < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, Shop::Types::Integer

      attribute :account_id, Shop::Types::Integer
      attribute? :account, Account

      attribute :items, Types.Array(Item).default([])
      attribute :status, Shop::Types::OrderStatuses

      def payed?
        self.status == Shop::Types::OrderPayedStatus[]
      end
    end
  end
end
