require 'rails_helper'

RSpec.describe 'Mutations::Profile::Update' do # rubocop:disable RSpec/DescribeClass
  include GraphqlSpecHelper

  let!(:user) { create(:user) }
  let(:profile) { user }

  let(:query) do
    <<~QUERY
      mutation UpdateProfile($variables:updateProfileInput!) {
        updateProfile(input: $variables) {
          profile {
            name
            email
          }
          errors {
            path
            message
          }
        }
      }
    QUERY
  end
  let(:operation_name) { 'UpdateProfile' }
  let(:variables) do
    {
      'variables': {
        'id': id,
        'attributes': {
          'name': name,
          'email': email
        }
      }
    }
  end

  let(:id) { profile.id }
  let(:name) { 'name foo' }
  let(:email) { 'foo bar baz' }

  context 'ログインしている時' do
    let(:query_context) { { current_user: user } }

    context '入力値が正しい場合' do
      let(:expected_value) do
        {
          updateProfile: {
            profile: {
              name: name,
              email: email
            },
            errors: []
          }
        }.deep_stringify_keys
      end

      it 'プロフィールのデータが返ること' do
        expect(data).to eq expected_value
      end

      it 'ユーザーが増えないこと' do
        expect { subject }.not_to change(User, :count)
      end
    end

    context 'idに該当するプロフィールが存在しない時' do
      let(:id) { 999_999 }

      let(:expected_value) do
        {
          message: "Couldn't find User with 'id'=999999",
          path: ['updateProfile'],
          locations: [{ line: 2, column: 3 }],
          extensions: { 'code' => 'Errors::NotFound' }
        }.deep_stringify_keys
      end

      it 'Errorが返ること' do
        expect(errors[0]).to eq expected_value
      end

      it 'ユーザーが増えないこと' do
        expect { subject }.not_to change(User, :count)
      end
    end

    context 'emailが空文字列だった場合' do
      let(:email) { '' }

      let(:expected_value) do
        {
          updateProfile: {
            profile: nil,
            errors: [error]
          }
        }.deep_stringify_keys
      end

      let(:error) do
        {
          message: 'を入力してください',
          path: ['attributes', 'email'],
        }
      end

      it 'Errorが返ること' do
        expect(data).to eq expected_value
      end

      it 'ユーザーが増えないこと' do
        expect { subject }.not_to change(User, :count)
      end
    end
  end

  context 'ログインしていない時' do
    let(:expected_value) do
      {
        message: 'ログインが必要です',
        path: ['updateProfile'],
        locations: [{ line: 2, column: 3 }],
        extensions: { 'code' => 'Errors::Unauthorized' }
      }.deep_stringify_keys
    end

    it 'Errors::Unauthorizedが返ること' do
      expect(errors[0]).to eq expected_value
    end
  end
end
