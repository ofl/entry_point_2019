# == Schema Information
#
# Table name: users
#
#  id               :bigint(8)        not null, primary key
#  avatar           :string(100)
#  crypted_password :string           not null
#  email            :string(100)      not null
#  name             :string(50)       not null
#  salt             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

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

  def to_builder
    Jbuilder.new do |user|
      user.id id.to_s
      user.name name
      user.avatar avatar
      user.__typename 'User'
    end
  end
end
