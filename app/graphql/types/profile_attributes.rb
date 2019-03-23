class Types::ProfileAttributes < Types::BaseInputObject
  description 'Attributes for profile'

  argument :name, String, 'Name for the update profile', required: true
  argument :email, String, 'Email for the update profile', required: true
  argument :avatar, ApolloUploadServer::Upload, 'Avatar Image File for the update profile', required: false
end
