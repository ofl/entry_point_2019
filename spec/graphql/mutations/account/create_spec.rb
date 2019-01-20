require 'rails_helper'

RSpec.describe 'Mutations::Account::Create' do # rubocop:disable RSpec/DescribeClass
  include GraphqlSpecHelper

  let!(:user) { create(:user) }

  let(:query) do
    <<~QUERY
      mutation CreateAccount($variables:createAccountInput!) {
        createAccount(input: $variables) {
          account {
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
  let(:operation_name) { 'CreateAccount' }
  let(:variables) do
    {
      'variables': {
        'attributes': {
          'name': name,
          'email': email,
          'password': password,
          'passwordConfirmation': password_confirmation
        }
      }
    }
  end

  let(:name) { 'foo' }
  let(:email) { 'foo@example.com' }
  let(:password) { 'password' }
  let(:password_confirmation) { 'password' }

  context 'ログインしていない時' do
    context '入力値が正しい場合' do
      let(:expected_value) do
        {
          createAccount: {
            account: {
              name: name,
              email: email
            },
            errors: []
          }
        }.deep_stringify_keys
      end

      it 'ユーザーのデータが返ること' do
        expect(data).to eq expected_value
      end

      it 'ユーザーが作成されること' do
        expect { subject }.to change(User, :count).by(1)
      end
    end

    context 'emailが空文字列だった場合' do
      let(:email) { '' }

      let(:expected_value) do
        {
          createAccount: {
            account: nil,
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

  context 'ログインしている時' do
    let(:query_context) { { current_user: user } }

    let(:expected_value) do
      {
        message: 'リクエストが正しくありません',
        path: ['createAccount'],
        locations: [{ line: 2, column: 3 }],
        extensions: { 'code' => 'Errors::BadRequest' }
      }.deep_stringify_keys
    end

    it 'Errors::BadRequestが返ること' do
      expect(errors[0]).to eq expected_value
    end
  end
end
