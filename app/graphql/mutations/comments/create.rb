class Mutations::Comments::Create < GraphQL::Schema::RelayClassicMutation
  graphql_name 'createComment'
  description 'コメントの追加'

  null true

  argument :article_id, ID, required: true, description: '記事ID'
  argument :attributes, Types::CommentAttributes, required: true, description: 'コメント属性'

  field :comment, Types::CommentType, null: true
  field :article, Types::ArticleType, null: true
  field :errors, [Types::UserError], null: false

  def resolve(article_id:, attributes:)
    current_user = context[:current_user]
    raise Errors::Unauthorized if current_user.nil?

    article = Article.find(article_id)
    comment = article.comments.build(attributes.to_h.merge(user: current_user))

    if comment.save
      { comment: comment, article: article.reload, errors: [] }
    else
      user_errors = comment.errors.map { |attribute, message| { path: ['attributes', attribute], message: message } }
      { comment: nil, article: nil, errors: user_errors }
    end
  end
end
