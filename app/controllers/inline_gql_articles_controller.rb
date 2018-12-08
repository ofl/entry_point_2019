class InlineGqlArticlesController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  # GET /inline_gql_articles
  def index
    @articles = Article.includes(:user).all.order(created_at: :desc)
    gon.jbuilder
  end

  # GET /inline_gql_articles/1
  def show
    @article = Article.includes(comments: [:user]).find(params[:id])
    gon.jbuilder
  end

  # GET /inline_gql_articles/new
  def new
    @article = current_user.articles.build
    gon.jbuilder
  end

  # GET /inline_gql_articles/1/edit
  def edit
    @article = current_user.articles.find(params[:id])
    gon.jbuilder
  end
end
