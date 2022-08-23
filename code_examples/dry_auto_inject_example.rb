# ===================== dry-container with dry-auto_inject example ======================

puts

require 'dry/container'
require 'dry/auto_inject'

#setup container
class Container
  extend Dry::Container::Mixin

  register(:time_dependency) { ->() { puts Time.now } }

  register(:dependency_one) { DependencyOne.new }
  register(:dependency_two) { DependencyTwo.new }
  register(:dependency_three) { DependencyThree.new }
end

# Set up your auto-injection mixin
Import = Dry::AutoInject(Container)

# will also works
# Import = Dry::AutoInject(Hash.new)

class DependencyOne
  include Import[dependency: :dependency_two]

  # Same as:
  #
  #   attr_reader :dependency
  #  
  #   def initialize(dependency: Container[:dependency_two])
  #     @dependency = dependency
  #   end

  def call
    dependency.call
    puts 'Hello from dependency one'
  end
end

class DependencyTwo
  include Import[dependency: :dependency_three]

  def call
    dependency.call
    puts 'Hello from dependency two'
  end
end

class DependencyThree
  include Import[dependency: :time_dependency]

  def call
    dependency.call
    puts 'Hello from dependency three'
  end
end

puts "Container keys: #{Container.keys}"
puts

logic = Container[:dependency_one]
logic.call
