# frozen_string_literal: true

require "hanami/api"
require "hanami/middleware/body_parser"
require 'hanami/action'

module HTTP
  class App < Hanami::API
    use Hanami::Middleware::BodyParser, :json

    get '/' do
      "Hello, world"
    end

    get '/order/:id', to: Container['http.actions.queries.show_order']

    post '/checkout', to: Container['http.actions.commands.checkout']
    post '/order/:id/add', to: Container['http.actions.commands.add_items_to_order']
  end
end
