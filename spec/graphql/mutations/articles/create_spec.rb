require 'rails_helper'

RSpec.describe 'Mutations::Articles::Create' do # rubocop:disable RSpec/DescribeClass
  include GraphqlSpecHelper

  let!(:user) { create(:user) }

  let(:query) do
    <<~QUERY
      mutation CreateArticle($variables:createArticleInput!) {
        createArticle(input: $variables) {
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
  let(:operation_name) { 'CreateArticle' }
  let(:variables) do
    {
      'variables': {
        'attributes': {
          'title': title,
          'body': body
        }
      }
    }
  end

  let(:title) { 'title foo' }
  let(:body) { 'foo bar baz' }

  context 'ログインしている時' do
    let(:query_context) { { current_user: user } }

    context '入力値が正しい場合' do
      let(:expected_value) do
        {
          createArticle: {
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

      it '記事が作成されること' do
        expect { subject }.to change(Article, :count).by(1)
      end
    end

    context 'bodyが空文字列だった場合' do
      let(:body) { '' }

      let(:expected_value) do
        {
          createArticle: {
            article: nil,
            errors: [error]
          }
        }.deep_stringify_keys
      end

      let(:error) do
        {
          message: "can't be blank",
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
  end

  context 'ログインしていない時' do
    let(:expected_value) do
      {
        message: 'ログインが必要です',
        path: ['createArticle'],
        locations: [{ line: 2, column: 3 }],
        extensions: { 'code' => 'Errors::Unauthorized' }
      }.deep_stringify_keys
    end

    it 'Errors::Unauthorizedが返ること' do
      expect(errors[0]).to eq expected_value
    end
  end
end
