require 'rails_helper'

RSpec.describe 'Mutations::Articles::Update' do # rubocop:disable RSpec/DescribeClass
  include GraphqlSpecHelper

  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: posted_user) }
  let(:posted_user) { user }

  let(:query) do
    <<~QUERY
      mutation UpdateArticle($variables:updateArticleInput!) {
        updateArticle(input: $variables) {
          article {
            title
            body
            user {
              name
            }
          }
          errors {
            path
            message
          }
        }
      }
    QUERY
  end
  let(:operation_name) { 'UpdateArticle' }
  let(:variables) do
    {
      'variables': {
        'id': id,
        'attributes': {
          'title': title,
          'body': body
        }
      }
    }
  end

  let(:id) { article.id }
  let(:title) { 'title foo' }
  let(:body) { 'foo bar baz' }

  context 'ログインしている時' do
    let(:query_context) { { current_user: user } }

    context '入力値が正しい場合' do
      let(:expected_value) do
        {
          updateArticle: {
            article: {
              title: title,
              body: body,
              user: {
                name: user.name
              }
            },
            errors: []
          }
        }.deep_stringify_keys
      end

      it '記事のデータが返ること' do
        expect(data).to eq expected_value
      end

      it '記事が増えないこと' do
        expect { subject }.not_to change(Article, :count)
      end
    end

    context 'idに該当する投稿が存在しない時' do
      let(:id) { 999_999 }

      let(:expected_value) do
        {
          message: "Couldn't find Article with 'id'=999999",
          path: ['updateArticle'],
          locations: [{ line: 2, column: 3 }],
          extensions: { 'code' => 'Errors::NotFound' }
        }.deep_stringify_keys
      end

      it 'Errorが返ること' do
        expect(errors[0]).to eq expected_value
      end

      it '記事が増えないこと' do
        expect { subject }.not_to change(Article, :count)
      end
    end

    context 'bodyが空文字列だった場合' do
      let(:body) { '' }

      let(:expected_value) do
        {
          updateArticle: {
            article: nil,
            errors: [error]
          }
        }.deep_stringify_keys
      end

      let(:error) do
        {
          message: 'を入力してください',
          path: ['attributes', 'body'],
        }
      end

      it 'Errorが返ること' do
        expect(data).to eq expected_value
      end

      it '記事が増えないこと' do
        expect { subject }.not_to change(Article, :count)
      end
    end

    context '自分以外の記事の場合' do
      let(:posted_user) { create(:user) }

      let(:expected_value) do
        {
          message: 'アクセスできません',
          path: ['updateArticle'],
          locations: [{ line: 2, column: 3 }],
          extensions: { 'code' => 'Errors::Forbidden' }
        }.deep_stringify_keys
      end

      it 'Errorが返ること' do
        expect(errors[0]).to eq expected_value
      end

      it '記事が増えないこと' do
        expect { subject }.not_to change(Article, :count)
      end
    end
  end

  context 'ログインしていない時' do
    let(:expected_value) do
      {
        message: 'ログインが必要です',
        path: ['updateArticle'],
        locations: [{ line: 2, column: 3 }],
        extensions: { 'code' => 'Errors::Unauthorized' }
      }.deep_stringify_keys
    end

    it 'Errors::Unauthorizedが返ること' do
      expect(errors[0]).to eq expected_value
    end
  end
end
