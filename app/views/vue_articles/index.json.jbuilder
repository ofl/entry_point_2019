json.articles @articles do |article|
  json.id article.id
  json.title article.title
  json.createdAt article.created_at.xmlschema
  json.likesCount article.likes_count
  json.commentsCount article.comments_count

  json.user article.user.to_builder
end
