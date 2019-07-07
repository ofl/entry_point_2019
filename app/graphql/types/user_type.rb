class Types::UserType < Types::BaseObject
  description 'ユーザー'

  field :id, ID, null: true, description: 'ユーザーID'
  field :name, String, null: false, description: 'ユーザー名'
  field :email, String, null: false, description: 'メールアドレス'
  field :avatarUrl, String, null: true, description: 'アバター'
  field :followerCount, Integer, null: false, description: 'フォロワー数'
  field :followingCount, Integer, null: false, description: 'フォロー数'
  field :followedByMe, Boolean, null: true, description: 'フォロー済みかどうか'
end
