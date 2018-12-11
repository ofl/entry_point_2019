class Mutations::Articles::Destroy < GraphQL::Schema::RelayClassicMutation
  graphql_name 'destroyArticle'
  description '記事の削除'

  null true

  argument :id, ID, description: '記事ID', required: true

  field :article, Types::ArticleType, null: true
  field :errors, [Types::UserError], null: false

  def resolve(id:)
    current_user = context[:current_user]
    raise Errors::Unauthorized if current_user.nil?

    article = Article.find(id)
    raise Errors::Forbidden if article.user != current_user

    article.destroy

    { article: article, errors: [] }
  end
end
