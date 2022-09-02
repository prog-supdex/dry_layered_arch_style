module ToyTestings
  module Relations
    class Toys < ROM::Relation[:sql]
      schema(:toys, infer: true)

    end
  end
end
