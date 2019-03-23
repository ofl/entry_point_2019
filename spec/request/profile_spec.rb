require 'rails_helper'

RSpec.describe 'Profile', type: :request do
  let(:user) { create(:user) }

  describe 'GET /profile/edit' do
    subject { get edit_profile_path }

    context 'ログインしているとき' do
      before { login_user(user, 'password', login_url) }

      it 'プロフィール修正画面が表示されること' do
        is_expected.to eq 200
      end
    end

    context 'ログインしていないとき' do
      it 'ログイン画面にリダイレクトされること' do
        is_expected.to redirect_to '/login'
      end
    end
  end
end
