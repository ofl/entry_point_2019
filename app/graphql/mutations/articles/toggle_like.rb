class Mutations::Articles::ToggleLike < GraphQL::Schema::RelayClassicMutation
  graphql_name 'articleToggleLike'
  description 'いいねの登録/解除'

  null true

  argument :id, ID, required: true, description: '記事ID'

  field :article, Types::ArticleType, null: true
  field :errors, [Types::UserError], null: false

  def resolve(id:)
    current_user = context[:current_user]
    raise Errors::Unauthorized if current_user.nil?

    article = Article.find(id)
    article.toggle_like(current_user)

    { article: article, errors: [] }
  end
end
