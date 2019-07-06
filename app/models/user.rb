# == Schema Information
#
# Table name: users
#
#  id                            :bigint(8)        not null, primary key
#  avatar_data(アバター画像情報) :string
#  crypted_password              :string           not null
#  email                         :string(100)      not null
#  follower_count                :integer          default(0), not null
#  following_count               :integer          default(0), not null
#  name                          :string(50)       not null
#  salt                          :string           not null
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#

class User < ApplicationRecord
  authenticates_with_sorcery!
  attribute :followed_by_me, :boolean, default: false

  include AvatarUploader[:avatar]

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, :name, presence: true, uniqueness: true

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships

  def following?(other_user)
    following_relationships.where(following_id: other_user.id).exists?
  end

  def followed_by?(other_user)
    self.followed_by_me = follower_relationships.where(follower_id: other_user.id).exists?
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

  def to_builder
    Jbuilder.new do |user|
      user.id id.to_s
      user.name name
      user.avatarUrl avatar_url
      user.followerCount follower_count
      user.followingCount following_count
      user.__typename 'User'
    end
  end
end
