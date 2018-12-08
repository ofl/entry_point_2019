class Mutations::Articles::Create < GraphQL::Schema::RelayClassicMutation
  graphql_name 'createArticle'
  description '記事の作成'

  null true

  argument :attributes, Types::ArticleAttributes, required: true, description: '記事属性'

  field :article, Types::ArticleType, null: true
  field :errors, [Types::UserError], null: false

  def resolve(attributes:)
    current_user = context[:current_user]
    raise Errors::Unauthorized if current_user.nil?

    article = current_user.articles.build(attributes.to_h)

    if article.save
      { article: article, errors: [] }
    else
      user_errors = article.errors.map { |attribute, message| { path: ['attributes', attribute], message: message } }
      { article: nil, errors: user_errors }
    end
  end
end
