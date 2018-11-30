class Article < ApplicationRecord
  attribute :liked_by_me, :boolean, default: false

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, :body, presence: true

  def liked_by?(user)
    self.liked_by_me = likes.by_user(user).exists?
  end
end
