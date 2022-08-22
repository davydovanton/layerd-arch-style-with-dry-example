Container.register_provider(:http_configuration) do |container|
  prepare do
    require 'hanami/action/configuration'

    # Docs for hanami action response format:
    #   https://github.com/hanami/controller/blob/505c932db9c4236fa5eb9f8461d813a12e3fd968/lib/hanami/action/configuration.rb#L218-L245
    hanami_action_config = Hanami::Action::Configuration.new do |config|
      config.default_response_format = :json
    end

    register('hanami.action.configuration', hanami_action_config)
  end
end
