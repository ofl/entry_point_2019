class Queries::Articles::Search < GraphQL::Schema::Resolver
  graphql_name 'Search Articles'
  description '記事をキーワード検索で絞り込む'

  type [Types::ArticleType], null: false

  argument :keyword, String, required: true

  def resolve(keyword:)
    Article.includes(:user).search(keyword).order(created_at: :desc)
  end
end
