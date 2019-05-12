require 'rails_helper'

RSpec.describe 'Queries::Users::Show' do # rubocop:disable RSpec/DescribeClass
  include GraphqlSpecHelper

  let!(:user) { create(:user) }

  let(:query) do
    <<~QUERY
      query User($id: ID!){
        user(id: $id) {
          id
          name
          avatarUrl
        }
      }
    QUERY
  end
  let(:operation_name) { 'User' }
  let(:variables) { { id: id } }


  context 'IDに該当するユーザーが存在する時' do
    let(:id) { user.id }
    let(:expected_value) do
      {
        user: {
          id: user.id.to_s,
          name: user.name,
          avatarUrl: user.avatar_url,
        }
      }.deep_stringify_keys
    end

    it 'ユーザーのデータが返ること' do
      expect(data).to eq expected_value
    end
  end

  context 'IDに該当するユーザーが存在しない時' do
    let(:id) { 999_999 }

    let(:expected_value) do
      { user: nil }.deep_stringify_keys
    end

    it 'ユーザーのデータが返ること' do
      expect(data).to eq expected_value
    end
  end
end
