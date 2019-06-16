# == Schema Information
#
# Table name: articles
#
#  id              :bigint(8)        not null, primary key
#  body            :text
#  comments_count  :integer          default(0), not null
#  favorites_count :integer          default(0), not null
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint(8)
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
  attribute :faved_by_me, :boolean, default: false

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  scope :search, ->(keyword) { where('title LIKE ?', "%#{keyword}%").or(where('body LIKE ?', "%#{keyword}%")) }

  def faved_by?(user)
    self.faved_by_me = favorites.by_user(user).exists?
  end

  def toggle_favorite(user)
    favorite = favorites.find_by(user: user)
    favorite.present? ? favorite.destroy : favorites.create(user: user)

    reload
    self.faved_by_me = !favorite.present?
  end
end
