require_relative '.././config/boot'

puts

# p account = Shop::Entities::Account.new(id: 1, email: 'test@test.com', address: 'Some address here')
# p account = Shop::Entities::Account.new(id: 1, name: nil, email: 'test@test.com', address: 'Some address here')
p account = Shop::Entities::Account.new(id: 1, name: 'Anton', email: 'test@test.com', address: 'Some address here')

puts

p items = [
  # Shop::Entities::Item.new(id: 11, title: 'T', count: 1), # will raise error
  # Shop::Entities::Item.new(id: 11, title: 'Test title for item #11', count: 0), # will raise error

  Shop::Entities::Item.new(id: 11, title: 'Test title for item #11', count: 2),
  Shop::Entities::Item.new(id: 12, title: 'Test title for item #12', count: 3),
  Shop::Entities::Item.new(id: 13, title: 'Test title for item #13', count: 1)
]

puts

order = Shop::Entities::Order.new(id: 2, account: account, items: items)

p order
p order.account
p order.items
