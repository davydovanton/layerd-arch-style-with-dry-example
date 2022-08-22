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

            # if you want to use serelezation you can do something like this:
            #
            # 1. create a new pure function-class in `apps/http/serelizations/../serelization_name.rb`
            # 2. add specific logic. IMPORTANT: this logic should be pure
            # 3. inject serelization object in to action `include Import[serelizator: 'http.serelizations. ... .serelization_name']`
            # 4. call it in action: `res.body = serelizator.call(data)`
            # 5. update fitness functions
            # 6. add specs for serelizator in `spec/apps/http/serelizators/.../serelizator_name_spec.rb`
            # ...
            # 7. PROFIT

            res.body    = result.value!.to_json
          in Failure[_, error_message]
            halt 422, error_message.to_json
          end
        end
      end
    end
  end
end
