module ToyTestings
  module Commands
    class AssignToyToAccount
      include Dry::Monads[:result, :try]
      include Dry::Monads::Do.for(:call)

      MONEY_PER_APPROVE = 1000

      include Import[
        test_repo: 'contexts.accounts.repositories.test',
        toy_repo: 'contexts.accounts.repositories.toy',
        account_repo: 'contexts.accounts.repositories.account'
      ]

      def call(toy_id:, account_id:)
        account, toy = yield find_account_and_toy_in_test(account_id, toy_id)

        yield check_for_blocked_account(account)
        yield check_for_existing_approved_toy(toy_id, account_id)
        yield check_for_existing_toy_in_tests(toy)

        toy = yield set_toy_to_test(toy, account)

        Success(account: account, toy: toy)
      end

      private

      def find_account_and_toy_in_test(account_id, toy_id)
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

      def enrollment_balance(account)
        Success(account_repo.changeset(account.id, balance: account.balance + MONEY_PER_APPROVE).commit)
      end

      def check_for_blocked_account(account)
        if account.status == "blocked"
          Failure(
            [
              :account_blocked,
              { account: account}
            ]
          )
        end
      end

      def check_for_existing_approved_toy(toy_id, account_id)
        unless test_repo.approved_toy_exist_in_test?(toy_id, account_id)
          Failure(
            [
              :toy_declined,
              { account_id: account_id, toy_id: toy_id}
            ]
          )
        end
      end
    end
  end
end
