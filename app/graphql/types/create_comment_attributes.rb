class Types::CreateCommentAttributes < Types::BaseInputObject
  description 'Attributes for creating a post comment'
  argument :body, String, 'Body for the post comment', required: true
end
