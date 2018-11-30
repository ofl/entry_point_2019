require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { create(:article, user: create(:user)) }

  describe '#toggle_like' do
    subject { article.toggle_like(user) }

    let(:user) { create(:user) }

    context 'ユーザーのLikeが存在しない場合' do
       it 'Likeが作成されること' do
         expect { subject }.to change(Like, :count).by(1)
       end

       it '#liked_by_meがtrueになること' do
         subject
         expect(article.liked_by_me).to be_truthy
       end
    end

    context 'ユーザーのLikeが存在する場合' do
      before do
        create(:like, user: user, article: article)
      end

       it 'Likeが削除されること' do
         expect { subject }.to change(Like, :count).by(-1)
       end

       it '#liked_by_meがfalseになること' do
         subject
         expect(article.liked_by_me).to be_falsey
       end
    end
  end
end
