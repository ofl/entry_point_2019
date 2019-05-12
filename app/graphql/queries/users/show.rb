class Queries::Users::Show < GraphQL::Schema::Resolver
  graphql_name 'User'
  description '指定したIDのユーザーを取得する'

  type Types::UserType, null: true

  argument :id, ID, required: true

  def resolve(id:)
    User.find_by(id: id)
  end
end
