require "dry/system/provider_sources"

Container.register_provider(:settings, from: :dry_system) do
  before :prepare do
    require_relative "../../lib/core/types"
  end

  settings do
    # setting :database_url, constructor: Core::Types::String.constrained(filled: true)
    #
    # setting :logger_level, default: :info, constructor: Core::Types::Symbol
    #   .constructor { |value| value.to_s.downcase.to_sym }
    #   .enum(:trace, :unknown, :error, :fatal, :warn, :info, :debug)
  end
end
