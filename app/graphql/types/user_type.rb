class Types::UserType < Types::BaseObject
  description 'ユーザー'

  field :id, ID, null: true, description: 'ユーザーID'
  field :name, String, null: false, description: 'ユーザー名'
  field :avatar, String, null: true, description: 'アバター'
end
