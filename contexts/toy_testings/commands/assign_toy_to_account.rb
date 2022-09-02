module ToyTestings
  module Commands
    class AssignToyToAccount
      include Dry::Monads[:result, :try]
      include Dry::Monads::Do.for(:call)

      include Import[
        test_repo: 'contexts.toy_testings.repositories.test',
        toy_repo: 'contexts.toy_testings.repositories.toy',
        account_repo: 'contexts.toy_testings.repositories.account'
      ]

      def call(toy_id, account_id)
        account, toy = yield find_account_and_order(account_id, toy_id)

        yield check_toys_in_test_queue(account)
        yield check_for_existing_toy_in_tests(toy)

        toy = yield set_toy_to_test(toy, account)

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

      def set_toy_to_test(toy, account)
        Success(test_repo.create(account_id: account.id, toy_id: toy.id))
      end

      def check_toys_in_test_queue(account)
        if test_repo.count_toys_in_test_by_account_id(account.id) >= 3
          return Failure([:max_toys_in_test, { account: account }])
        end

        Success(account: account)
      end

      def check_for_existing_toy_in_tests(toy)
        if test_repo.toy_exist_in_test?(toy.id)
          return Failure([:toy_already_in_test, { toy: toy }])
        end

        Success(toy: toy)
      end
    end
  end
end
