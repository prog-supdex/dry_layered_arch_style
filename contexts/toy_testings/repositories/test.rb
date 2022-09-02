module ToyTestings
  module Repositories
    class Test < ROM::Repository[:tests]
      include Import["container" => "rom_container"]

      commands :create,
        use: :timestamps,
        plugins_options: {
          timestamps: {
            timestamps: %i[created_at updated_at]
          }
        }

      def toys_in_test_by_account_id(account_id)
        tests.where(account_id: account_id, status: "pending")
      end

      def find_test_with_pending_by_toy_id_and_account_id(account_id, toy_id)
        tests.find(account_id: account_id, toy_id: toy_id, status: "pending")
      end

      def count_toys_in_test_by_account_id(account_id)
        toys_in_test_by_account_id(account_id).count
      end

      def toy_exist_in_test?(toy_id)
        tests.exist?(toy_id: toy_id)
      end

      def update_comment_and_status(toy_id:, comment:, status:)
        tests.where(toy_id: toy_id).changeset(:update, comment: comment, status: status).commit
      end
    end
  end
end
