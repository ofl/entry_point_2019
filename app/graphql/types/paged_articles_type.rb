class Types::PagedArticlesType < Types::BaseObject
  description '記事一覧'

  field :articles, [Types::ArticleType], null: false, description: '記事'
  field :hasMore, Boolean, null: false, description: '「もっと読む」記事が存在するか'
end
