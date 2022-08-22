# frozen_string_literal: true

require 'json'
require 'hanami/action'

module HTTP
  module Actions
    module Commands
      class Checkout < Hanami::Action
        include Dry::Monads[:result]

        include Import[
          configuration: 'hanami.action.configuration',
          command: 'contexts.shop.commands.checkout'
        ]

        def handle(req, res)
          result = command.call(order_id: req.params[:id], account_id: req.session[:account_id])

          case result
          in Success
            res.status  = 200
            res.body    = result.value!.to_json
          in Failure[:order_and_account_not_founded, error_message]
            halt 404, error_message.to_json
          in Failure[:invalid_account_email, error_message]
            halt 422, error_message.to_json
          in Failure[:order_empty, error_message]
            halt 422, error_message.to_json
          in Failure[:order_already_payed, error_message]
            halt 422, error_message.to_json
          in Failure[:order_status_invalid, error_message]
            halt 422, error_message.to_json
          end
        end
      end
    end
  end
end
