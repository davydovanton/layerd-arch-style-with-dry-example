require_relative '.././config/boot'

puts

puts '--------------- Matcher context -------------------'

puts 'Matcher account:'

p Matcher::Entities::Account.new(id: 1, characteristic: 'asdasdasdasd', name: 'Anton', email: 'test@test.com', address: 'Some address here')

p Matcher::Entities::CatToy.new(id: 1, title: 'something', characteristic: 123)

puts
puts
puts '--------------- Shop context -------------------'
puts

puts 'Shop account:'

# p account = Shop::Entities::Account.new(id: 1, email: 'test@test.com', address: 'Some address here')
# p account = Shop::Entities::Account.new(id: 1, name: nil, email: 'test@test.com', address: 'Some address here')
p account = Shop::Entities::Account.new(id: 1, characteristic: 'asdasdasdasd', name: 'Anton', email: 'test@test.com', address: 'Some address here')

puts

p items = [
  # Shop::Entities::Item.new(id: 11, title: 'T', count: 1), # will raise error
  # Shop::Entities::Item.new(id: 11, title: 'Test title for item #11', count: 0), # will raise error

  Shop::Entities::Item.new(id: 11, title: 'Test title for item #11', count: 2, order_id: 2),
  Shop::Entities::Item.new(id: 12, title: 'Test title for item #12', count: 3, order_id: 2),
  Shop::Entities::Item.new(id: 13, title: 'Test title for item #13', count: 1, order_id: 2)
]

puts

# order = Shop::Entities::Order.new(id: 2, account_id: account.id, account: account, items: items, status: 'wrong')
order = Shop::Entities::Order.new(id: 2, account_id: account.id, account: account, items: items)

p order
p order.account
p order.items
