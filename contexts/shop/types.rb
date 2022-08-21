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
    OrderOpenStatus = Types.Value('open').default('open'.freeze)
    OrderPayedStatus = Types.Value('payed').default('payed'.freeze)
    OrderStatuses = (OrderOpenStatus | OrderPayedStatus).default('open'.freeze)
  end
end
