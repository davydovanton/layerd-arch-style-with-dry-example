class Railway
  StepError = StandardError

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

    { success: true, value: { step_1: :success, **payload } }
  end

  def step_2(payload)
    # some code

    { success: true, value: { step_2: :success, **payload } }
    # { failure: true, error: 'Some error happen in step #2' }
  end

  def step_3(payload)
    # some code

    { success: true, value: { step_3: :success, **payload } }
  end

  def result_handle(result)
    case result
    in { success: true, value: value }
      value
    in { failure: true, error: error }
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
