class Types::AccountAttributes < Types::BaseInputObject
  description 'Attributes for account'

  argument :name, String, 'Name for the post account', required: true
  argument :email, String, 'Email for the post account', required: true
  argument :password, String, 'Password for the post account', required: true
  argument :passwordConfirmation, String, 'Password for the post account', required: true
end
