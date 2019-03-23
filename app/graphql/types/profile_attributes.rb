class Types::ProfileAttributes < Types::BaseInputObject
  description 'Attributes for profile'

  argument :name, String, 'Name for the post profile', required: true
  argument :email, String, 'Email for the post profile', required: true
end
