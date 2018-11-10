class Mutations::Comments::Update < GraphQL::Schema::RelayClassicMutation
  graphql_name 'updateComment'
  description 'コメントの修正'

  null true

  argument :id, ID, description: 'コメントID', required: true
  argument :attributes, Types::CommentAttributes, required: true, description: 'コメント属性'

  field :comment, Types::CommentType, null: true
  field :errors, [Types::UserError], null: false

  def resolve(id:, attributes:)
    current_user = context[:current_user]
    raise Errors::Unauthorized if current_user.nil?

    comment = Comment.find(id)
    raise Errors::Forbidden if comment.user != current_user

    if comment.update(attributes.to_h)
      { comment: comment, errors: [] }
    else
      user_errors = comment.errors.map { |attribute, message| { path: ['attributes', attribute], message: message } }
      { comment: nil, errors: user_errors }
    end
  end
end
