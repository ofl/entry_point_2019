class Queries::Users::CurrentUser < GraphQL::Schema::Resolver
  graphql_name 'CurrentUser'
  description '現在アクセスしているユーザーを取得する'

  type Types::UserType, null: true

  def resolve
    context[:current_user]
  end
end
