require_relative '../../config/boot'

puts 'Loaded container:'
puts "container: #{Container}"
puts "container keys: #{Container.keys}"

puts
puts '*' * 40
puts

Container['in_memory.transport.matcher_request'].call
puts
puts '*' * 40
puts
Container['in_memory.transport.shop_request'].call
