module ToyTestings
  module Repositories
    class Toy < ROM::Repository[:toys]
      include Import["container" => "rom_container"]

      commands :create,
        use: :timestamps,
          plugins_options: {
          timestamps: {
            timestamps: %i[created_at updated_at]
          }
        }

      def all
        toys.to_a
      end

      def find_by_id(id)
        toys.where(id: id).one
      end
    end
  end
end
