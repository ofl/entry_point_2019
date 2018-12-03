class Queries::Articles::Index < GraphQL::Schema::Resolver
  graphql_name 'Article Index'
  description '記事の一覧を取得する'

  type [Types::ArticleType], null: false

  def resolve
    Article.includes(:user).all.order(created_at: :desc)
  end
end
