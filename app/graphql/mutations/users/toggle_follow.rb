class Mutations::Users::ToggleFollow < GraphQL::Schema::RelayClassicMutation
  graphql_name 'userToggleFollow'
  description 'フォロー/解除'

  null true

  argument :name, String, required: true, description: 'ユーザー名'

  field :user, Types::UserType, null: true
  field :errors, [Types::UserError], null: false

  def resolve(name:)
    current_user = context[:current_user]
    raise Errors::Unauthorized if current_user.nil?

    user = User.find_by!(name: name)
    user.toggle_followed_by!(current_user)

    { user: user, errors: [] }
  end
end
