# frozen_string_literal: true

module InMemory
  module Transports
    class AccountRequest
      include Import[service: "contexts.accounts.service"]

      def call
        puts "Running InMemory::Transports::AccountRequest"
        puts "Doing some logic"

        sleep 0.5

        service.call

        sleep 0.5
        puts "Done"
      end
    end
  end
end
