# frozen_string_literal: true

module InMemory
  module Transports
    class ToyTestingRequest
      include Import[service: "contexts.toy_testings.service"]

      def call
        puts "Running InMemory::Transports::ToyTestingRequest"
        puts "Doing some logic"

        sleep 0.5

        service.call

        sleep 0.5
        puts "Done"
      end
    end
  end
end
