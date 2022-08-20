require 'parser/current'

module FitnessFunctions
  class ParseFileDependencies
    def call(file_path)
      file = File.read("#{__dir__}/../#{file_path}")

      node = Parser::CurrentRuby.parse(file).loc.node
      find_dependencies(node.to_sexp_array)
    end

  private

    def select_include_nodes(sexp)
      sexp.select { |node| node[0] == :send && node[1] == nil && node[2] == :include }
    end

    def find_di_import_node(import_sexps)
      import_sexps.find { |node| Array(node[3][1])[2] == :Import }
    end

    def get_imported_dependencies(import_sexp)
      import_sexp.nil? ? [] : import_sexp[3][3][1..-1].map{ |n| n[2][1] }
    end

    def find_dependencies(sexp)
      di_imports = []

      loop do
        sexp = sexp.pop

        if sexp[0] == :begin 
          di_imports = get_imported_dependencies(
            find_di_import_node(
              select_include_nodes(sexp)
            )
          )
          break 
        else
          next
        end
      end

      di_imports
    end
  end

  class CrossContextCallsChecker
    def call(file_path, type:, context:, whitelist: [])
      di_imports = ParseFileDependencies.new.call(file_path)

      puts "Checking: '#{file_path}', type: '#{type}', context: '#{context}'"
      puts "Dependencies for file: #{di_imports}"

      di_imports.each do |dependency|
        next if dependency.start_with?(*whitelist)

        raise "Invalid dependency '#{dependency}' for '#{context}' context" unless dependency.include?(context.to_s)
      end
    end
  end
end

# =========================================

puts
puts

whitelist = %w[lib contexts]


file_path = 'apps/in_memory/transport/matcher_request.rb'
FitnessFunctions::CrossContextCallsChecker.new.call(file_path, type: :transport, context: :matcher, whitelist: whitelist)

puts
puts '****'
puts

file_path = 'apps/in_memory/transport/shop_request.rb'
FitnessFunctions::CrossContextCallsChecker.new.call(file_path, type: :transport, context: :shop, whitelist: whitelist)

puts
puts '****'
puts

file_path = 'contexts/shop/service.rb'
FitnessFunctions::CrossContextCallsChecker.new.call(file_path, type: :business_logic, context: :shop, whitelist: ['lib'])


# [:send, [:const, nil, :Import],
# binding.irb
# :end
