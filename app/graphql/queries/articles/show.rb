class Queries::Articles::Show < GraphQL::Schema::Resolver
  graphql_name 'Article'
  description '指定したIDの記事を取得する'

  type Types::ArticleType, null: true

  argument :id, ID, required: true

  def resolve(id:)
    Article.find_by(id: id)
  end
end
