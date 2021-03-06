require 'rails_helper'

RSpec.describe 'Mutations::Articles::ToggleFavorite' do # rubocop:disable RSpec/DescribeClass
  include GraphqlSpecHelper

  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: create(:user)) }

  let(:query) do
    <<~QUERY
      mutation ArticleToggleFavorite($variables:articleToggleFavoriteInput!) {
        articleToggleFavorite(input: $variables) {
          article {
            id
            favoritesCount
            favedByMe
          }
          errors {
            path
            message
          }
        }
      }
    QUERY
  end
  let(:operation_name) { 'ArticleToggleFavorite' }
  let(:variables) do
    {
      'variables': {
        'id': id
      }
    }
  end

  let(:id) { article.id }

  context 'ログインしている時' do
    let(:query_context) { { current_user: user } }

    context '入力値が正しい場合' do
      let(:expected_value) do
        {
          articleToggleFavorite: {
            article: {
              id: article.id.to_s,
              favoritesCount: 1,
              favedByMe: true
            },
            errors: []
          }
        }.deep_stringify_keys
      end

      it '記事のデータが返ること' do
        expect(data).to eq expected_value
      end

      it 'Favoriteが１件増えること' do
        expect { subject }.to change(Favorite, :count).by(1)
      end
    end

    context 'idに該当する投稿が存在しない時' do
      let(:id) { 999_999 }

      let(:expected_value) do
        {
          message: "Couldn't find Article with 'id'=999999",
          path: ['articleToggleFavorite'],
          locations: [{ line: 2, column: 3 }],
          extensions: { 'code' => 'Errors::NotFound' }
        }.deep_stringify_keys
      end

      it 'Errorが返ること' do
        expect(errors[0]).to eq expected_value
      end

      it 'Favoriteが増えないこと' do
        expect { subject }.not_to change(Favorite, :count)
      end
    end
  end

  context 'ログインしていない時' do
    let(:expected_value) do
      {
        message: 'ログインが必要です',
        path: ['articleToggleFavorite'],
        locations: [{ line: 2, column: 3 }],
        extensions: { 'code' => 'Errors::Unauthorized' }
      }.deep_stringify_keys
    end

    it 'Errors::Unauthorizedが返ること' do
      expect(errors[0]).to eq expected_value
    end
  end
end
