class VueArticlesController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  # GET /vue_articles
  def index
    articles = Article.includes(:user).all.order(created_at: :desc)
    gon.articles = articles.as_json(include: :user)
  end

  # GET /vue_articles/1
  def show
    article = Article.find(params[:id])
    gon.article = article.as_json(include: { user: { only: user_attributes }, comments: { include: { user: { only: user_attributes } } } })
  end

  # GET /vue_articles/new
  def new
    article = current_user.articles.build
    gon.article = article.as_json(include: { user: { only: user_attributes } })
  end

  # GET /vue_articles/1/edit
  def edit
    article = current_user.articles.find(params[:id])
    gon.article = article.as_json(include: { user: { only: user_attributes } })
  end

  # POST /vue_articles
  def create
    article = current_user.articles.build(article_params)

    if article.save
      redirect_to(vue_article_path(article), notice: 'Article was successfully created.')
    else
      gon.article = article.as_json(include: { user: { only: user_attributes } })
      render :new
    end
  end

  # PATCH/PUT /vue_articles/1
  def update
    article = current_user.articles.find(params[:id])
    if article.update(article_params)
      redirect_to(vue_article_path(article), notice: 'Article was successfully updated.')
    else
      gon.article = article.as_json(include: { user: { only: user_attributes } })
      render :edit
    end
  end

  # DELETE /vue_articles/1
  def destroy
    article = current_user.articles.find(params[:id])
    article.destroy
    redirect_to vue_articles_url, notice: 'Article was successfully destroyed.'
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def user_attributes
    %i(id name avatar)
  end
end
