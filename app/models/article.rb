# == Schema Information
#
# Table name: articles
#
#  id             :bigint(8)        not null, primary key
#  body           :text
#  comments_count :integer          default(0), not null
#  likes_count    :integer          default(0), not null
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint(8)
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Article < ApplicationRecord
  attribute :liked_by_me, :boolean, default: false

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  scope :search, ->(keyword) { where('title LIKE ?', "%#{keyword}%").or(where('body LIKE ?', "%#{keyword}%")) }

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
