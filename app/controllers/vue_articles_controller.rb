class VueArticlesController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  # GET /vue_articles
  def index
    @articles = Article.includes(:user).all.order(created_at: :desc)
    gon.jbuilder
  end

  # GET /vue_articles/1
  def show
    @article = Article.includes(comments: [:user]).find(params[:id])
    gon.jbuilder
  end

  # GET /vue_articles/new
  def new
    @article = current_user.articles.build
    gon.jbuilder
  end

  # GET /vue_articles/1/edit
  def edit
    @article = current_user.articles.find(params[:id])
    gon.jbuilder
  end

  # POST /vue_articles
  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      redirect_to(vue_article_path(@article), notice: 'Article was successfully created.')
    else
      render :new
    end
  end

  # PATCH/PUT /vue_articles/1
  def update
    @article = current_user.articles.find(params[:id])
    if @article.update(article_params)
      redirect_to(vue_article_path(@article), notice: 'Article was successfully updated.')
    else
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
end
