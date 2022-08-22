# require "dry/cli"

# require 'faye/websocket'

module Websockets
  # App = lambda do |env|
  #   if Faye::WebSocket.websocket?(env)
  #     ws = Faye::WebSocket.new(env)
  #
  #     ws.on :message do |event|
  #       result = Container['...'].call
  #       ...
  #       ws.send(result)
  #     end
  #
  #     ws.on :close do |event|
  #       # ...
  #     end
  #
  #     # Return async Rack response
  #     ws.rack_response
  #
  #   else
  #     # Normal HTTP request
  #     [200, { 'Content-Type' => 'text/plain' }, ['Hello']]
  #   end
  # end
end
