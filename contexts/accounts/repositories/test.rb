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

      def approved_toy_exist_in_test?(toy_id, account_id)
        tests.exist?(toy_id: toy_id, account_id: account_id, status: "approved")
      end
    end
  end
end
