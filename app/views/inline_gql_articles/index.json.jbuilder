json.articles @articles do |article|
  json.id article.id.to_s
  json.title article.title
  json.createdAt article.created_at.xmlschema
  json.likesCount article.likes_count
  json.commentsCount article.comments_count
  json.__typename 'Article'

  json.user article.user.to_builder
end
