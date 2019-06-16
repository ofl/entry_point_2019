class Types::ArticleType < Types::BaseObject
  description '記事'

  field :id, ID, null: false, description: '記事ID'
  field :title, String, null: false, description: 'タイトル'
  field :body, String, null: false, description: '本文'
  field :user, Types::UserType, null: false, description: '投稿者'
  field :comments, [Types::CommentType], null: false, description: 'コメント'
  field :commentsCount, Integer, null: false, description: 'コメント数'
  field :favoritesCount, Integer, null: false, description: 'いいね数'
  field :favedByMe, Boolean, null: false, description: '閲覧者がいいねしたかどうか'
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false, description: '作成日時'
end
