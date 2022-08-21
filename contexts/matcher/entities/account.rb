module Matcher
  module Entities
    class Account < Dry::Struct
      transform_keys(&:to_sym)

      attribute :id, Shop::Types::Integer

      attribute :characteristic, Matcher::Types::AccountCharacteristic
    end
  end
end
