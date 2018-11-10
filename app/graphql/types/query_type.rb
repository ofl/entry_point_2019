module Types
  class QueryType < Types::BaseObject
    description 'The query root of this schema'

    field :article,         resolver: Queries::Articles::Show
  end
end
