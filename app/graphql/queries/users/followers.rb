class Queries::Users::Followers < GraphQL::Schema::Resolver
  graphql_name 'User Follower Index'
  description '対象ユーザーをフォローしているユーザーの一覧を取得する'

  type [Types::UserType], null: false

  argument :name, String, required: true

  def resolve(name:)
    user = User.find_by(name: name)
    user.followers
  end
end
