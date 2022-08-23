# ===================== dry-container example ======================

puts

class DependencyOne
  attr_reader :dependency

  def initialize(dependency:)
    @dependency = dependency
  end

  def call
    dependency.call
    puts 'Hello from dependency one'
  end
end

class DependencyTwo
  attr_reader :dependency

  def initialize(dependency:)
    dependency.call
    @dependency = dependency
  end

  def call
    puts 'Hello from dependency two'
  end
end

class DependencyThree
  attr_reader :dependency

  def initialize(dependency:)
    @dependency = dependency
  end

  def call
    dependency.call
    puts 'Hello from dependency three'
  end
end

# Same logic

# container = {}
# container[:time_dependency]  = ->() { puts Time.now }
#
# container[:dependency_three] = DependencyThree.new(dependency: container[:time_dependency])
# container[:dependency_two]   = DependencyTwo.new(dependency: container[:dependency_three])
# container[:dependency_one]   = DependencyOne.new(dependency: container[:dependency_two])
#
#
# logic = container[:dependency_one]
# logic.call

require 'dry/container'

container = Dry::Container.new

container.register(:time_dependency, ->() { puts Time.now }, call: false)

container.register(:dependency_three) do
  DependencyThree.new(dependency: container.resolve(:time_dependency))
end

container.register(:dependency_two) do
  DependencyTwo.new(dependency: container.resolve(:dependency_three))
end

container.register(:dependency_one) do
  DependencyOne.new(dependency: container.resolve(:dependency_two))
end

puts "Container keys: #{container.keys}"
puts

logic = container.resolve(:dependency_one)
logic.call
