require 'dry/monads'
require 'dry/monads/do'

include Dry::Monads[:result]

class Railway
  StepError = StandardError
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  def call(payload)
    puts "Start railway logic with '#{payload}'"

    value = yield step_1(payload)
    puts "Result of step 1: '#{value}'"

    value = yield step_2(payload)
    puts "Result of step 2: '#{value}'"

    value = yield step_3(payload)
    puts "Result of step 3: '#{value}'"

    Success(value)
  end

private

  def step_1(payload)
    # some code

    Success({ step_1: :success, **payload })
  end

  def step_2(payload)
    # some code

    Success({ step_2: :success, **payload })
    # Failure('Some error happen in step #2')
  end

  def step_3(payload)
    # some code

    Success({ step_3: :success, **payload })
  end
end

puts
puts

logic = Railway.new

case result = logic.call(start: true)
in Success(value)
  puts "Railway logic completed with '#{value}' result"
in Failure(error)
  puts "Railway logic failured with '#{error}' message"
end
