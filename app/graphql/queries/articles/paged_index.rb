class Queries::Articles::PagedIndex < GraphQL::Schema::Resolver
  graphql_name 'Article More Index'
  description '記事の一覧ともっと見る情報を取得する'

  type Types::PagedArticlesType, null: false

  argument :page, Int, required: false
  argument :page_size, Int, required: false

  def resolve(page: 1, page_size: 20)
    articles = Article.includes(:user).all.order(created_at: :desc).page(page).per(page_size)

    { articles: articles, has_more: !articles.last_page? }
  end
end
