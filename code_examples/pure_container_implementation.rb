# ===================== pure DI container example ======================

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

# problem here

logic = DependencyOne.new(
  dependency: DependencyTwo.new(
    dependency: DependencyThree.new(dependency: ->() { puts Time.now }))
)

logic.call

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
