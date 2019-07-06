require 'rails_helper'

RSpec.describe 'Queries::Users::Followings' do # rubocop:disable RSpec/DescribeClass
  include GraphqlSpecHelper

  let!(:user) { create(:user) }
  let!(:another_user) { create(:user) }

  let(:query) do
    <<~QUERY
      query Followings($name: String!) {
        followings(name: $name) {
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
      followings: [
        {
          id: another_user.id.to_s,
          name: another_user.name
        }
      ]
    }.deep_stringify_keys
  end

  before do
    user.follow!(another_user)
  end

  it '対象ユーザーがフォローしているユーザーのデータが返ること' do
    expect(data).to eq expected_value
  end
end
