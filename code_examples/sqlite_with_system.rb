require_relative '.././config/boot'
require 'pp'

puts

p Container['persistance.db']

puts

# === Create account ===

# pp Container['persistance.db'].execute "INSERT INTO accounts (name, email, address) VALUES (?, ?, ?) RETURNING id", 'Anton', 'test@shop.com', 'Some address here'
#
# pp raw_accounts = Container['persistance.db'].execute("SELECT * FROM accounts")
# p account = Shop::Entities::Account.new(raw_accounts.first.transform_keys(&:to_sym))

account_repo = Container['contexts.shop.repositories.account']
p account = account_repo.create(name: 'Anton', email: 'test@shop.com', address: 'Some address here')
puts

# === Create order ===

order_repo = Container['contexts.shop.repositories.order']
p order = order_repo.create(account_id: account.id)
puts

# === Add items ===

p order = order_repo.add_item(order_id: order.id, title: 'Item #1', count: 2)
p order = order_repo.add_item(order_id: order.id, title: 'Item #2', count: 1)
p order = order_repo.add_item(order_id: order.id, title: 'Item #3', count: 3)

puts

p filled_order = order_repo.find(id: order.id)


puts
puts '=== Change order status ==='
puts

p payed_order = order_repo.change_status(id: filled_order.id, status: 'payed')
