require 'dry/monads'

include Dry::Monads[:result]

class Railway
  StepError = StandardError
  include Dry::Monads[:result]

  def call(payload)
    puts "Start railway logic with '#{payload}'"

    value = result_handle(step_1(payload))
    puts "Result of step 1: '#{value}'"

    value = result_handle(step_2(value))
    puts "Result of step 2: '#{value}'"

    value = result_handle(step_3(value))
    puts "Result of step 3: '#{value}'"

    value
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

  def result_handle(result)
    case result
    in Success(value)
      value
    in Failure(error)
      fail StepError.new(error)
    end
  end
end

puts
puts

logic = Railway.new

begin
  result = logic.call(start: true)

  puts
  puts "Railway logic completed with '#{result}' result"
rescue Railway::StepError => e
  puts
  puts "Railway logic failured with '#{e.message}' message"
end


# ============================= Try monad example =======================================

# class Railway
#   StepError = StandardError
#   include Dry::Monads[:result]
#
#   def call(payload)
#     puts "Start railway logic with '#{payload}'"
#
#     step_1(payload).bind do |value|
#       puts "Result of step 1: '#{value}'"
#
#       step_2(value).bind do |next_value|
#         puts "Result of step 2: '#{value}'"
#
#         result = step_3(next_value)
#         puts "Result of step 3: '#{result.value!}'"
#         result
#       end
#     end
#   end
#
# private
#
#   def step_1(payload)
#     # some code
#
#     Success({ step_1: :success, **payload })
#   end
#
#   def step_2(payload)
#     # some code
#
#     Success({ step_2: :success, **payload })
#     # Failure('Some error happen in step #2')
#   end
#
#   def step_3(payload)
#     # some code
#
#     Success({ step_3: :success, **payload })
#   end
# end
#
# puts
# puts
#
# logic = Railway.new
#
# case result = logic.call(start: true)
# in Success(value)
#   puts "Railway logic completed with '#{value}' result"
# in Failure(error)
#   puts "Railway logic failured with '#{error}' message"
# end
