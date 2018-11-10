class AppSchema < GraphQL::Schema
  max_complexity 400
  max_depth 10
  mutation(Types::MutationType)
  query(Types::QueryType)
end
