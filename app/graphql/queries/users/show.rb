class Queries::Users::Show < GraphQL::Schema::Resolver
  graphql_name 'User'
  description '指定したIDのユーザーを取得する'

  type Types::UserType, null: true

  argument :name, String, required: true

  def resolve(name:)
    User.find_by(name: name)
  end
end
