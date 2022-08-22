# frozen_string_literal: true

require 'json'
require 'hanami/action'

module HTTP
  module Actions
    module Queries
      class ShowOrder < Hanami::Action
        include Dry::Monads[:result]

        include Import[
          configuration: 'hanami.action.configuration',
          query: 'contexts.shop.queries.show_order'
        ]

        def handle(req, res)
          result = query.call(order_id: req.params[:id], account_id: req.session[:account_id])

          case result
          in Success
            res.status  = 200
            res.body    = result.value!.to_json
          in Failure[_, error_message]
            halt 422, error_message.to_json
          end
        end
      end
    end
  end
end
