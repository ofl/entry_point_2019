json.article do
  json.__typename 'Article'
  json.id @article.id
  json.title @article.title
  json.body @article.body
  json.createdAt @article.created_at.xmlschema
  json.likesCount @article.likes_count
  json.commentsCount @article.comments_count
  json.likedByMe @article.liked_by?(current_user)

  json.user @article.user.to_builder

  json.comments @article.comments do |comment|
    json.__typename 'Comment'
    json.id comment.id
    json.body comment.body

    json.user comment.user.to_builder
  end
end
