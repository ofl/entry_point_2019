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

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'followings' do
    subject { user.followings }

    let(:another_user) { create(:user) }

    before do
      user.follow!(another_user)
    end

    it { is_expected.to contain_exactly(another_user) }
  end

  describe 'followers' do
    subject { user.followers }

    let(:another_user) { create(:user) }

    before do
      another_user.follow!(user)
    end

    it { is_expected.to contain_exactly(another_user) }
  end

  describe 'following?' do
    subject { user.following?(another_user) }

    let(:another_user) { create(:user) }

    before do
      user.follow!(another_user)
    end

    it { is_expected.to be_truthy }
  end

  describe 'followed_by?' do
    subject { user.followed_by?(another_user) }

    let(:another_user) { create(:user) }

    before do
      another_user.follow!(user)
    end

    it { is_expected.to be_truthy }
  end

  describe 'follow!' do
    subject { user.follow!(another_user) }

    let(:another_user) { create(:user) }

    it 'Relationshipが増えること' do
      expect { subject }.to change(Relationship, :count).by(1)
    end

    it 'userのfollowing_countが増えること' do
      expect(user.following_count).to eq 0
      subject
      expect(user.reload.following_count).to eq 1
    end

    it 'userのfollower_countが増えないこと' do
      expect(user.follower_count).to eq 0
      subject
      expect(user.reload.follower_count).to eq 0
    end

    it 'another_userのfollowing_countが増えないこと' do
      expect(another_user.following_count).to eq 0
      subject
      expect(another_user.reload.following_count).to eq 0
    end

    it 'another_userのfollower_countが増えること' do
      expect(another_user.follower_count).to eq 0
      subject
      expect(another_user.reload.follower_count).to eq 1
    end
  end
end
