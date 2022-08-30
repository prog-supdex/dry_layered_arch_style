# frozen_string_literal: true

module InMemory
  module Transports
    class ToyRequest
      include Import[service: "contexts.toys.service"]

      def call
        puts "Running InMemory::Transports::ToyRequest"
        puts "Doing some logic"

        sleep 0.5

        service.call

        sleep 0.5
        puts "Done"
      end
    end
  end
end
