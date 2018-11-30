class Like < ApplicationRecord
  belongs_to :user
  belongs_to :article
  counter_culture :article

  validates :article, presence: true
  validates :user, presence: true, uniqueness: { scope: :article }

  scope :by_user, ->(user) { where(user: user) }
end
