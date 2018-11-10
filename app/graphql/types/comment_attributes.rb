class Types::CommentAttributes < Types::BaseInputObject
  description 'Attributes for comment'
  argument :body, String, 'Body for the post comment', required: true
end
