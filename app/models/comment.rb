class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  counter_culture :article

  validates :body, presence: true
end
