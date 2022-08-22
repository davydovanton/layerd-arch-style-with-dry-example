# frozen_string_literal: true

require 'json'
require 'hanami/action'

module HTTP
  module Actions
    module Commands
      class AddItemsToOrder < Hanami::Action
        include Dry::Monads[:result]

        include Import[
          configuration: 'hanami.action.configuration',
          command: 'contexts.shop.commands.add_items_to_order'
        ]

        def handle(req, res)
          result = command.call(
            order_id: req.params[:id],
            account_id: req.session[:account_id],
            items: req.params[:items]
          )

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
