module Shop
  module Entities
    class Account < Dry::Struct
      attribute :id, Shop::Types::Integer

      attribute? :name, Shop::Types::AccountName
      attribute :email, Shop::Types::AccountEmail
      attribute :address, Shop::Types::AccountAddress
    end
  end
end
