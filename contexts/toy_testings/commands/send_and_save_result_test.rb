module ToyTestings
  module Commands
    class SendAndSaveResultTest
      include Dry::Monads[:result, :try]
      include Dry::Monads::Do.for(:call)

      include Import[
        test_repo: 'contexts.toy_testings.repositories.test',
        toy_repo: 'contexts.toy_testings.repositories.toy',
        account_repo: 'contexts.toy_testings.repositories.account'
      ]

      ItemValidator = Dry::Schema.Params do
        required(:items).array(:array, min_size?: 1) do
          required(:title).value(Shop::Types::ItemTitle)
          required(:count).value(Shop::Types::ItemCount)
        end
      end

      def call(toy_id:, account_id:, comment:, status:)
        account, toy = yield find_account_and_order(account_id, toy_id)

        yield check_for_existing_toy_in_test(toy, account)
        yield set_comment_and_status(toy: toy, comment: comment, status: status)

        Success(account: account, toy: toy)
      end

      private

      def find_account_and_order(account_id, toy_id)
        account = account_repo.find_by_id(account_id)
        toy = toy_repo.find_by_id(toy_id)

        if account && toy
          Success([account, toy])
        else
          Failure(
            [
              :toy_and_account_not_founded,
              { account_id: account_id, account: account, toy_id: toy_id, toy: toy}
            ]
          )
        end
      end

      def check_for_existing_toy_in_test(toy, account)
        toy_test = test_repo.find_test_with_pending_by_toy_id_and_account_id(account.id, toy.id)

        if toy_test
          Success(toy_test: test)
        else
          Failure(
            [
              :not_found_toy_test,
              { account: account, toy: toy}
            ]
          )
        end
      end

      def set_comment_and_status(toy:, comment:, status:)
        Success(test_repo.update_comment_and_status(toy_id: toy.id, comment: comment, status: status))
      end
    end
  end
end
