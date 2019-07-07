require 'rails_helper'

RSpec.describe 'Queries::Users::Followings' do # rubocop:disable RSpec/DescribeClass
  include GraphqlSpecHelper

  let!(:user) { create(:user) }
  let!(:another_user) { create(:user) }

  let(:query) do
    <<~QUERY
      query Followings($name: String!) {
        followers(name: $name) {
          id
          name
        }
      }
    QUERY
  end
  let(:operation_name) { 'Followings' }
  let(:variables) { { name: user.name } }

  let(:expected_value) do
    {
      followers: [
        {
          id: another_user.id.to_s,
          name: another_user.name
        }
      ]
    }.deep_stringify_keys
  end

  before do
    another_user.follow!(user)
  end

  it '対象ユーザーをフォローしているユーザーのデータが返ること' do
    expect(data).to eq expected_value
  end
end
