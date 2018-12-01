# == Schema Information
#
# Table name: users
#
#  id               :bigint(8)        not null, primary key
#  avatar           :string(100)
#  crypted_password :string           not null
#  email            :string(100)      not null
#  name             :string(50)       not null
#  salt             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user_#{n}" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    avatar { '' }
  end
end
