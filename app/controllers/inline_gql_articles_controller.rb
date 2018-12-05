class InlineGqlArticlesController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  # GET /spa_articles
  def index
  end

  # GET /spa_articles/1
  def show
  end

  # GET /spa_articles/new
  def new
  end

  # GET /spa_articles/1/edit
  def edit
  end
end
