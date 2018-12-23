json.article do
  json.id @article.id.to_s
  json.title @article.title
  json.body @article.body
end
