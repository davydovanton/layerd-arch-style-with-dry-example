# frozen_string_literal: true

Container.register_provider(:logger) do |container|
  init do
    # use :settings
    #
    # require 'semantic_logger'
    #
    # if container[:settings].logger_json_formatter == 'true'
    #   SemanticLogger.add_appender(io: logger_io, formatter: :json)
    # else
    #   SemanticLogger.add_appender(io: logger_io)
    # end
    #
    # SemanticLogger.default_level = container[:settings].logger_level
    # container.register(:logger, SemanticLogger['BillingBanshee'])
  end

  # detect default logger IO output
  def logger_io
    ENV['PROJECT_ENV'] == 'test' ? StringIO.new : STDOUT
  end
end
