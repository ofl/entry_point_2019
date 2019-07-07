require 'rails_helper'

RSpec.describe 'Mutations::Users::ToggleFollow' do # rubocop:disable RSpec/DescribeClass
  include GraphqlSpecHelper

  let!(:user) { create(:user) }
  let!(:anoher_user) { create(:user) }

  let(:query) do
    <<~QUERY
      mutation UserToggleFollow($variables:userToggleFollowInput!) {
        userToggleFollow(input: $variables) {
          user {
            name
            followerCount
            followedByMe
          }
          errors {
            path
            message
          }
        }
      }
    QUERY
  end
  let(:operation_name) { 'UserToggleFollow' }
  let(:variables) do
    {
      'variables': {
        'name': name
      }
    }
  end

  let(:name) { user.name }

  context 'ログインしている時' do
    let(:query_context) { { current_user: user } }

    context '入力値が正しい場合' do
      let(:expected_value) do
        {
          userToggleFollow: {
            user: {
              name: user.name.to_s,
              followerCount: 1,
              followedByMe: true
            },
            errors: []
          }
        }.deep_stringify_keys
      end

      it '記事のデータが返ること' do
        expect(data).to eq expected_value
      end

      it 'Relationshipが１件増えること' do
        expect { subject }.to change(Relationship, :count).by(1)
      end
    end

    context 'nameに該当する投稿が存在しない時' do
      let(:name) { 'foo' }

      let(:expected_value) do
        {
          message: "Couldn't find User",
          path: ['userToggleFollow'],
          locations: [{ line: 2, column: 3 }],
          extensions: { 'code' => 'Errors::NotFound' }
        }.deep_stringify_keys
      end

      it 'Errorが返ること' do
        expect(errors[0]).to eq expected_value
      end

      it 'Relationshipが増えないこと' do
        expect { subject }.not_to change(Relationship, :count)
      end
    end
  end

  context 'ログインしていない時' do
    let(:expected_value) do
      {
        message: 'ログインが必要です',
        path: ['userToggleFollow'],
        locations: [{ line: 2, column: 3 }],
        extensions: { 'code' => 'Errors::Unauthorized' }
      }.deep_stringify_keys
    end

    it 'Errors::Unauthorizedが返ること' do
      expect(errors[0]).to eq expected_value
    end
  end
end
