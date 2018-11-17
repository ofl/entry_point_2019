require 'rails_helper'

RSpec.describe 'Queries::Users::CurrentUser' do # rubocop:disable RSpec/DescribeClass
  include GraphqlSpecHelper

  let!(:user) { create(:user) }

  let(:query) do
    <<~QUERY
      query CurrentUser{
        currentUser {
          id
          name
        }
      }
    QUERY
  end
  let(:operation_name) { 'CurrentUser' }
  let(:query_context) { { current_user: user } }

  let(:expected_value) do
    {
      currentUser: {
        id: user.id.to_s,
        name: user.name
      }
    }.deep_stringify_keys
  end

  it 'ユーザーのデータが返ること' do
    expect(data).to eq expected_value
  end
end
