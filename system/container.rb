require 'dry/system/container'
require 'dry/system/container'
require "dry/system/loader/autoloading"
require "zeitwerk"

# --- Dry-rb requirements ---
require 'dry-types'
require 'dry/types'
Dry::Types.load_extensions(:monads)

require 'dry/schema'
require 'dry-schema'
Dry::Schema.load_extensions(:monads)

require 'dry-struct'

require 'dry/monads'
require 'dry/monads/do'
# ---------------------------

# INFORMATION: for more expamples of providers you can check this link:
#   https://github.com/davydovanton/rubyjobs.dev/tree/master/system/boot

# General container class for project dependencies
#
# {http://dry-rb.org/gems/dry-system/ Dry-system documentation}
class Container < Dry::System::Container
  use :env, inferrer: -> { ENV.fetch('PROJECT_ENV', :development).to_sym }
  use :zeitwerk

  configure do |config|
    # libraries
    config.component_dirs.add 'lib' do |dir|
      dir.memoize = true

      dir.auto_register = proc do |component|
        !component.identifier.include?("types")
      end
    end

    # business logic
    config.component_dirs.add 'contexts' do |dir|
      dir.memoize = true

      dir.auto_register = proc do |component|
        !component.identifier.include?("entities")
        !component.identifier.include?("types")
      end

      dir.namespaces.add 'matcher', key: 'contexts.matcher'
      dir.namespaces.add 'shop', key: 'contexts.shop'
    end

    # simple transport
    config.component_dirs.add 'apps' do |dir|
      dir.memoize = true

      dir.namespaces.add 'in_memory', key: 'in_memory'
      dir.namespaces.add 'http', key: 'http' # if ENV['APP_TRANSPORT'] == 'http'
      dir.namespaces.add 'kafka', key: 'kafka' # if ENV['APP_TRANSPORT'] == 'kafka'

      # you need to load all as a classes, but I forgot hot to do it
      dir.namespaces.add 'cli', key: 'cli' # if ENV['APP_TRANSPORT'] == 'cli'

      dir.namespaces.add 'websockets', key: 'websockets' # if ENV['APP_TRANSPORT'] == 'websockets'
      dir.namespaces.add 'telegram_bot', key: 'telegram_bot' # if ENV['APP_TRANSPORT'] == 'telegram_bot'
      # etc
    end
  end
end

Import = Container.injector
