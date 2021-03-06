# == Schema Information
#
# Table name: favorites
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint(8)
#  user_id    :bigint(8)
#
# Indexes
#
#  index_favorites_on_article_id              (article_id)
#  index_favorites_on_user_id                 (user_id)
#  index_favorites_on_user_id_and_article_id  (user_id,article_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (user_id => users.id)
#

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :article
  counter_culture :article

  validates :article, presence: true
  validates :user, presence: true, uniqueness: { scope: :article }

  scope :by_user, ->(user) { where(user: user) }

  delegate :title, :created_at, :favorites_count, :comments_count, :user, to: :article, prefix: :article
end
