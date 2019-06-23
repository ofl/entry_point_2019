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

class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :following, class_name: 'User'

  counter_culture :follower, column_name: 'follower_count'
  counter_culture :following, column_name: 'following_count'

  validates :follower_id, presence: true
  validates :following_id, presence: true
end
