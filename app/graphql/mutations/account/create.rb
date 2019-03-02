class Mutations::Account::Create < GraphQL::Schema::RelayClassicMutation
  graphql_name 'createAccount'
  description 'アカウントの登録'

  null true

  argument :attributes, Types::AccountAttributes, required: true, description: 'アカウント属性'

  field :account, Types::UserType, null: true
  field :errors, [Types::UserError], null: false

  def resolve(attributes:)
    current_user = context[:current_user]
    raise Errors::BadRequest if current_user.present?

    user = User.new(attributes.to_h)

    if user.save
      { account: user, errors: [] }
    else
      user_errors = user.errors.map { |attribute, message| { path: ['attributes', attribute], message: message } }
      { account: nil, errors: user_errors }
    end
  end
end
