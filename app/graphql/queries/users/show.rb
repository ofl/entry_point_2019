class Queries::Users::Show < GraphQL::Schema::Resolver
  graphql_name 'User'
  description '指定したIDのユーザーを取得する'

  type Types::UserType, null: true

  argument :name, String, required: true

  def resolve(name:)
    user = User.find_by(name: name)
    user.followed_by?(context[:current_user]) if context[:current_user]
    user
  end
end
