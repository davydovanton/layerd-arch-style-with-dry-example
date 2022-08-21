module Shop
  module Libs
    class AddressCorrectnessChecker
      include Dry::Monads[:result]


      def call(address:)
        # some logic for validating logic. For example sofmething like this:
        #   google_maps.call(address)A
        #

        Success(address)
      end
    end
  end
end
