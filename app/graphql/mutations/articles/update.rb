class Mutations::Articles::Update < GraphQL::Schema::RelayClassicMutation
  graphql_name 'updateArticle'
  description '記事の修正'

  null true

  argument :id, ID, description: '記事ID', required: true
  argument :attributes, Types::ArticleAttributes, required: true, description: '記事属性'

  field :article, Types::ArticleType, null: true
  field :errors, [Types::UserError], null: false

  def resolve(id:, attributes:)
    current_user = context[:current_user]
    raise Errors::Unauthorized if current_user.nil?

    article = Article.find(id)
    raise Errors::Forbidden if article.user != current_user

    if article.update(attributes.to_h)
      { article: article, errors: [] }
    else
      user_errors = article.errors.map { |attribute, message| { path: ['attributes', attribute], message: message } }
      { article: nil, errors: user_errors }
    end
  end
end
