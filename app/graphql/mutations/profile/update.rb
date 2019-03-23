class Mutations::Profile::Update < GraphQL::Schema::RelayClassicMutation
  graphql_name 'updateProfile'
  description 'プロフィールの修正'

  null true

  argument :id, ID, description: 'プロフィールID', required: true
  argument :attributes, Types::ProfileAttributes, required: true, description: 'プロフィール属性'

  field :profile, Types::UserType, null: true
  field :errors, [Types::UserError], null: false

  def resolve(id:, attributes:)
    current_user = context[:current_user]
    raise Errors::Unauthorized if current_user.nil?

    profile = User.find(id)
    raise Errors::Forbidden if profile != current_user

    if profile.update(attributes.to_h)
      { profile: profile, errors: [] }
    else
      user_errors = profile.errors.map { |attribute, message| { path: ['attributes', attribute], message: message } }
      { profile: nil, errors: user_errors }
    end
  end
end
