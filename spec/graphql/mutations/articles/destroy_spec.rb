require 'rails_helper'

RSpec.describe 'Mutations::Articles::Destroy' do # rubocop:disable RSpec/DescribeClass
  include GraphqlSpecHelper

  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: posted_user) }
  let(:posted_user) { user }

  let(:query) do
    <<~QUERY
      mutation DestroyArticle($variables:destroyArticleInput!) {
        destroyArticle(input: $variables) {
          article {
            id
          }
          errors {
            path
            message
          }
        }
      }
    QUERY
  end
  let(:operation_name) { 'DestroyArticle' }
  let(:variables) do
    {
      'variables': {
        'id': id,
      }
    }
  end

  let(:id) { article.id }
  let(:body) { 'foo bar baz' }

  context 'ログインしている時' do
    let(:query_context) { { current_user: user } }

    context '入力値が正しい場合' do
      let(:expected_value) do
        {
          destroyArticle: {
            article: { id: article.id.to_s  },
            errors: []
          }
        }.deep_stringify_keys
      end

      it '記事がnilで返ること' do
        expect(data).to eq expected_value
      end

      it '記事が削除されること' do
        expect { subject }.to change(Article, :count).by(-1)
      end
    end

    context 'idに該当する投稿が存在しない時' do
      let(:id) { 999_999 }

      let(:expected_value) do
        {
          message: "Couldn't find Article with 'id'=999999",
          path: ['destroyArticle'],
          locations: [{ line: 2, column: 3 }],
          extensions: { 'code' => 'Errors::NotFound' }
        }.deep_stringify_keys
      end

      it 'Errorが返ること' do
        expect(errors[0]).to eq expected_value
      end

      it '記事が削除されないこと' do
        expect { subject }.not_to change(Article, :count)
      end
    end

    context '自分以外の記事の場合' do
      let(:posted_user) { create(:user) }

      let(:expected_value) do
        {
          message: 'アクセスできません',
          path: ['destroyArticle'],
          locations: [{ line: 2, column: 3 }],
          extensions: { 'code' => 'Errors::Forbidden' }
        }.deep_stringify_keys
      end

      it 'Errorが返ること' do
        expect(errors[0]).to eq expected_value
      end

      it '記事が削除されないこと' do
        expect { subject }.not_to change(Article, :count)
      end
    end
  end

  context 'ログインしていない時' do
    let(:expected_value) do
      {
        message: 'ログインが必要です',
        path: ['destroyArticle'],
        locations: [{ line: 2, column: 3 }],
        extensions: { 'code' => 'Errors::Unauthorized' }
      }.deep_stringify_keys
    end

    it 'Errors::Unauthorizedが返ること' do
      expect(errors[0]).to eq expected_value
    end
  end
end
