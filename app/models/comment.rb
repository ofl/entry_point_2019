class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  counter_culture :article

  validates :user, :article, presence: true
  validates :body, presence: true
end
