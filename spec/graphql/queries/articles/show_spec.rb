require 'rails_helper'

RSpec.describe 'Queries::Articles::Show' do # rubocop:disable RSpec/DescribeClass
  include GraphqlSpecHelper

  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }

  let(:query) do
    <<~QUERY
      query Article($id: ID!){
        article(id: $id) {
          id
          title
          body
        }
      }
    QUERY
  end
  let(:operation_name) { 'Article' }
  let(:variables) { { id: id } }

  context 'nameに該当する記事が存在する時' do
    let(:id) { article.id }
    let(:expected_value) do
      {
        article: {
          id: article.id.to_s,
          title: article.title,
          body: article.body,
        }
      }.deep_stringify_keys
    end

    it '記事のデータが返ること' do
      expect(data).to eq expected_value
    end
  end

  context 'nameに該当する記事が存在しない時' do
    let(:id) { 999_999 }

    let(:expected_value) do
      { article: nil }.deep_stringify_keys
    end

    it '記事のデータが返ること' do
      expect(data).to eq expected_value
    end
  end
end
