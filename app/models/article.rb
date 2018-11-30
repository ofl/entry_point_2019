class Article < ApplicationRecord
  attribute :liked_by_me, :boolean, default: false

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, :body, presence: true

  def liked_by?(user)
    self.liked_by_me = likes.by_user(user).exists?
  end

  def toggle_like(user)
    like = likes.find_by(user: user)
    liked_by_user = like.present?

    liked_by_user ? like.destroy : likes.create(user: user)

    reload
    self.liked_by_me = !liked_by_user
  end
end
