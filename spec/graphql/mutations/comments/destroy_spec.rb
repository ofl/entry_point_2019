require 'rails_helper'

RSpec.describe 'Mutations::Comments::Destroy' do # rubocop:disable RSpec/DescribeClass
  include GraphqlSpecHelper

  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: create(:user)) }
  let!(:comment) { create(:comment, user: commented_user, article: article) }
  let(:commented_user) { user }

  let(:query) do
    <<~QUERY
      mutation DestroyComment($variables:destroyCommentInput!) {
        destroyComment(input: $variables) {
          comment {
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
  let(:operation_name) { 'DestroyComment' }
  let(:variables) do
    {
      'variables': {
        'id': id,
      }
    }
  end

  let(:id) { comment.id }
  let(:body) { 'foo bar baz' }

  context 'ログインしている時' do
    let(:query_context) { { current_user: user } }

    context '入力値が正しい場合' do
      let(:expected_value) do
        {
          destroyComment: {
            comment: {
              id: comment.id.to_s
            },
            errors: []
          }
        }.deep_stringify_keys
      end

      it 'コメントがnilで返ること' do
        expect(data).to eq expected_value
      end

      it 'コメントが削除されること' do
        expect { subject }.to change(Comment, :count).by(-1)
      end
    end

    context 'idに該当する投稿が存在しない時' do
      let(:id) { 999_999 }

      let(:expected_value) do
        {
          message: "Couldn't find Comment with 'id'=999999",
          path: ['destroyComment'],
          locations: [{ line: 2, column: 3 }],
          extensions: { 'code' => 'Errors::NotFound' }
        }.deep_stringify_keys
      end

      it 'Errorが返ること' do
        expect(errors[0]).to eq expected_value
      end

      it 'コメントが削除されないこと' do
        expect { subject }.not_to change(Comment, :count)
      end
    end

    context '自分以外のコメントの場合' do
      let(:commented_user) { create(:user) }

      let(:expected_value) do
        {
          message: 'アクセスできません',
          path: ['destroyComment'],
          locations: [{ line: 2, column: 3 }],
          extensions: { 'code' => 'Errors::Forbidden' }
        }.deep_stringify_keys
      end

      it 'Errorが返ること' do
        expect(errors[0]).to eq expected_value
      end

      it 'コメントが削除されないこと' do
        expect { subject }.not_to change(Comment, :count)
      end
    end
  end

  context 'ログインしていない時' do
    let(:expected_value) do
      {
        message: 'ログインが必要です',
        path: ['destroyComment'],
        locations: [{ line: 2, column: 3 }],
        extensions: { 'code' => 'Errors::Unauthorized' }
      }.deep_stringify_keys
    end

    it 'Errors::Unauthorizedが返ること' do
      expect(errors[0]).to eq expected_value
    end
  end
end
