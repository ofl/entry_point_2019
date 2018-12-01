# == Schema Information
#
# Table name: likes
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint(8)
#  user_id    :bigint(8)
#
# Indexes
#
#  index_likes_on_article_id              (article_id)
#  index_likes_on_user_id                 (user_id)
#  index_likes_on_user_id_and_article_id  (user_id,article_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :like do
    user { nil }
    article { nil }
  end
end
