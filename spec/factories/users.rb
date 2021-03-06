# == Schema Information
#
# Table name: users
#
#  id                            :bigint(8)        not null, primary key
#  avatar_data(アバター画像情報) :string
#  crypted_password              :string           not null
#  email                         :string(100)      not null
#  follower_count                :integer          default(0), not null
#  following_count               :integer          default(0), not null
#  name                          :string(50)       not null
#  salt                          :string           not null
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user_#{n}" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }

    trait :with_avatar do
      avatar { File.open(Rails.root.join('spec', 'fixtures', 'files', 'youngman_31.png')) }
    end
  end
end
