class Types::UserType < Types::BaseObject
  description 'ユーザー'

  field :id, ID, null: true, description: 'ユーザーID'
  field :name, String, null: false, description: 'ユーザー名'
  field :email, String, null: false, description: 'メールアドレス'
  field :avatarUrl, String, null: true, description: 'アバター'
end
