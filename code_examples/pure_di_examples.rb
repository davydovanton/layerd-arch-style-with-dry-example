# ===================== DI in one function ======================

# def function(dependency:, payload:)
#   puts
#   dependency.call
#   puts payload
# end
#
# dependency = ->() { puts Time.now }
# function(dependency: dependency, payload: { a: 1, b: 2 })

# ===================== Functional object ======================

# class FunctionalObject
#   attr_reader :dependency
#
#   def initialize(dependency:)
#     @dependency = dependency
#   end
#
#   def call(payload:)
#     puts
#     dependency.call
#     puts 'Hello from functional object'
#   end
# end
#
# dependency = ->() { puts Time.now }
# function = FunctionalObject.new(dependency: dependency)
#
# function.call(payload: { a: 1, b: 2 })

# ===================== DI hell example ======================

# class DependencyOne
#   attr_reader :dependency
#
#   def initialize(dependency:)
#     @dependency = dependency
#   end
#
#   def call
#     dependency.call
#     puts 'Hello from dependency one'
#   end
# end
#
# class DependencyTwo
#   attr_reader :dependency
#
#   def initialize(dependency:)
#     dependency.call
#     @dependency = dependency
#   end
#
#   def call
#     puts 'Hello from dependency two'
#   end
# end
#
# class DependencyThree
#   attr_reader :dependency
#
#   def initialize(dependency:)
#     @dependency = dependency
#   end
#
#   def call
#     dependency.call
#     puts 'Hello from dependency three'
#   end
# end
#
# logic = DependencyOne.new(
#   dependency: DependencyTwo.new(
#     dependency: DependencyThree.new(dependency: ->() { puts Time.now }))
# )
#
# logic.call
