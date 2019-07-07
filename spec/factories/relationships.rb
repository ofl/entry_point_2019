# == Schema Information
#
# Table name: relationships
#
#  id           :bigint(8)        not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  follower_id  :integer          not null
#  following_id :integer          not null
#
# Indexes
#
#  index_relationships_on_follower_id                   (follower_id)
#  index_relationships_on_follower_id_and_following_id  (follower_id,following_id) UNIQUE
#  index_relationships_on_following_id                  (following_id)
#

FactoryBot.define do
  factory :relationship do
    follower_id { 1 }
    following_id { 1 }
  end
end
