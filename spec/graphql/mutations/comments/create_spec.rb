require 'rails_helper'

RSpec.describe 'Mutations::Comments::Create' do # rubocop:disable RSpec/DescribeClass
  include GraphqlSpecHelper

  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: create(:user)) }

  let(:query) do
    <<~QUERY
      mutation CreateComment($variables:createCommentInput!) {
        createComment(input: $variables) {
          comment {
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
  let(:operation_name) { 'CreateComment' }
  let(:variables) do
    {
      'variables': {
        'articleId': article_id,
        'attributes': {
          'body': body
        }
      }
    }
  end

  let(:article_id) { article.id }
  let(:body) { 'foo bar baz' }

  context 'ログインしている時' do
    let(:query_context) { { current_user: user } }

    context '入力値が正しい場合' do
      let(:expected_value) do
        {
          createComment: {
            comment: {
              body: body,
              user: {
                name: user.name
              }
            },
            errors: []
          }
        }.deep_stringify_keys
      end

      it 'コメントのデータが返ること' do
        expect(data).to eq expected_value
      end

      it 'コメントが１件増えること' do
        expect { subject }.to change(Comment, :count).by(1)
      end
    end

    context 'article_idに該当する投稿が存在しない時' do
      let(:article_id) { 999_999 }

      let(:expected_value) do
        {
          message: "Couldn't find Article with 'id'=999999",
          path: ['createComment'],
          locations: [{ line: 2, column: 3 }],
          extensions: { 'code' => 'Errors::NotFound' }
        }.deep_stringify_keys
      end

      it 'Errorが返ること' do
        expect(errors[0]).to eq expected_value
      end

      it 'コメントが増えないこと' do
        expect { subject }.not_to change(Comment, :count)
      end
    end

    context 'bodyが空文字列だった場合' do
      let(:body) { '' }

      let(:expected_value) do
        {
          createComment: {
            comment: nil,
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

      it 'コメントが増えないこと' do
        expect { subject }.not_to change(Comment, :count)
      end
    end
  end

  context 'ログインしていない時' do
    let(:expected_value) do
      {
        message: 'ログインが必要です',
        path: ['createComment'],
        locations: [{ line: 2, column: 3 }],
        extensions: { 'code' => 'Errors::Unauthorized' }
      }.deep_stringify_keys
    end

    it 'Errors::Unauthorizedが返ること' do
      expect(errors[0]).to eq expected_value
    end
  end
end
