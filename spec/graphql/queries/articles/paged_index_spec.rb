require 'rails_helper'

RSpec.describe 'Queries::Articles::PagedIndex' do # rubocop:disable RSpec/DescribeClass
  include GraphqlSpecHelper

  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }
  let!(:article2) { create(:article, user: user) }

  context 'with default arguments' do
    let(:query) do
      <<~QUERY
        query PagedArticles {
          pagedArticles {
            articles {
              id
              title
              user {
                name
              }
            }
            hasMore
          }
        }
      QUERY
    end
    let(:operation_name) { 'PagedArticles' }

    let(:expected_value) do
      {
        pagedArticles: {
          articles: [
            {
              id: article2.id.to_s,
              title: article2.title,
              user: {
                name: user.name
              }
            },
            {
              id: article.id.to_s,
              title: article.title,
              user: {
                name: user.name
              }
            }
          ],
          hasMore: false
        }
      }.deep_stringify_keys
    end

    it '投稿のデータが返ること' do
      expect(data).to eq expected_value
    end
  end

  context 'with paging arguments' do
    let(:query) do
      <<~QUERY
        query MoreArticles($page: Int!, $pageSize: Int!) {
          pagedArticles(page: $page, pageSize:$pageSize) {
            articles {
              id
              title
              user {
                name
              }
            }
            hasMore
          }
        }
      QUERY
    end
    let(:operation_name) { 'MoreArticles' }
    let(:variables) { { page: 1, pageSize: 1 } }

    let(:expected_value) do
      {
        pagedArticles: {
          articles: [
            {
              id: article2.id.to_s,
              title: article2.title,
              user: {
                name: user.name
              }
            },
          ],
          hasMore: true
        }
      }.deep_stringify_keys
    end

    it '投稿のデータが返ること' do
      expect(data).to eq expected_value
    end
  end
end
