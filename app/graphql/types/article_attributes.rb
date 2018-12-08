class Types::ArticleAttributes < Types::BaseInputObject
  description 'Attributes for article'
  argument :title, String, 'Title for the post article', required: true
  argument :body, String, 'Body for the post article', required: true
end
