# == Schema Information
#
# Table name: articles
#
#  id              :bigint(8)        not null, primary key
#  body            :text
#  comments_count  :integer          default(0), not null
#  favorites_count :integer          default(0), not null
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint(8)
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { create(:article, user: create(:user)) }

  describe '#toggle_favorite' do
    subject { article.toggle_favorite(user) }

    let(:user) { create(:user) }

    context 'ユーザーのFavoriteが存在しない場合' do
      it 'Favoriteが作成されること' do
        expect { subject }.to change(Favorite, :count).by(1)
      end

      it '#faved_by_meがtrueになること' do
        subject
        expect(article.faved_by_me).to be_truthy
      end
    end

    context 'ユーザーのFavoriteが存在する場合' do
      before do
        create(:favorite, user: user, article: article)
      end

      it 'Favoriteが削除されること' do
        expect { subject }.to change(Favorite, :count).by(-1)
      end

      it '#faved_by_meがfalseになること' do
        subject
        expect(article.faved_by_me).to be_falsey
      end
    end
  end
end
