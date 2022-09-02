module ToyTestings
  module Repositories
    class Account < ROM::Repository[:accounts]
      include Import["container" => "rom_container"]

      commands :create,
        use: :timestamps,
          plugins_options: {
          timestamps: {
            timestamps: %i[created_at updated_at]
          }
        }

      def all
        accounts.to_a
      end

      def find_by_id(id)
        accounts.where(id: id).one
      end
    end
  end
end
