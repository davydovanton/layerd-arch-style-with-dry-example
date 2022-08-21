require 'dry-types'

module Shop
  module Types
    include Dry.Types()

    # Types for item
    ItemTitle = String.constrained(min_size: 3)
    ItemCount = Integer.constrained(gteq: 1)

    # Types for account
    AccountName = String.optional
    AccountEmail = String.constrained(
      format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    )
    AccountAddress = String

    # Types for order
    OrderStatuses = Types::String.default('open'.freeze).enum('open', 'payed', 'delivered')
  end
end
