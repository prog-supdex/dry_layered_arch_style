module ToyTestings
  module Relations
    class Tests < ROM::Relation[:sql]
      schema(:tests, infer: true)

    end
  end
end
