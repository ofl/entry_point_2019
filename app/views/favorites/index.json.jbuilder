json.favorites @favorites do |favorite|
  json.id favorite.article_id.to_s
  json.title favorite.article_title
  json.createdAt favorite.article_created_at.xmlschema
  json.favoritesCount favorite.article_favorites_count
  json.commentsCount favorite.article_comments_count
  json.__typename 'Article'

  json.user favorite.article_user.to_builder
end
