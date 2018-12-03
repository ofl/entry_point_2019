require 'rails_helper'

RSpec.describe 'Queries::Articles::Index' do # rubocop:disable RSpec/DescribeClass
  include GraphqlSpecHelper

  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

  let(:query) do
    <<~QUERY
      query Articles {
        articles {
          id
          title
          user {
            name
          }
        }
      }
    QUERY
  end
  let(:operation_name) { 'Articles' }

  let(:expected_value) do
    {
      articles: [
        {
          id: article.id.to_s,
          title: article.title,
          user: {
            name: user.name
          }
        }
      ]
    }.deep_stringify_keys
  end

  it '投稿のデータが返ること' do
    expect(data).to eq expected_value
  end
end
