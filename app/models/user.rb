class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :name, uniqueness: true
  validates :email, uniqueness: true

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
