class Like < ApplicationRecord
  belongs_to :user
  belongs_to :article
  counter_culture :article

  scope :by_user, ->(user) { where(user: user) }
end
