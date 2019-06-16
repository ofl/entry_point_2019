json.article do
  json.id @article.id.to_s
  json.title @article.title
  json.body @article.body
  json.createdAt @article.created_at.xmlschema
  json.favoritesCount @article.favorites_count
  json.commentsCount @article.comments_count
  json.favoritedByMe @article.faved_by?(current_user)

  json.user @article.user.to_builder

  json.comments @article.comments do |comment|
    json.id comment.id.to_s
    json.title comment.body

    json.user comment.user.to_builder
  end
end
