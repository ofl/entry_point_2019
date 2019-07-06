class Queries::Users::Followings < GraphQL::Schema::Resolver
  graphql_name 'User Following Index'
  description 'フォロワーの一覧を取得する'

  type [Types::UserType], null: false

  argument :name, String, required: true

  def resolve(name:)
    user = User.find_by(name: name)
    user.followings
  end
end
