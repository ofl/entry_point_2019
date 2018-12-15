class Mutations::Comments::Destroy < GraphQL::Schema::RelayClassicMutation
  graphql_name 'destroyComment'
  description 'コメントの削除'

  null true

  argument :id, ID, description: 'コメントID', required: true

  field :comment, Types::CommentType, null: true
  field :article, Types::ArticleType, null: true
  field :errors, [Types::UserError], null: false

  def resolve(id:)
    current_user = context[:current_user]
    raise Errors::Unauthorized if current_user.nil?

    comment = Comment.find(id)
    raise Errors::Forbidden if comment.user != current_user

    comment.destroy

    { comment: comment, article: comment.article, errors: [] }
  end
end
