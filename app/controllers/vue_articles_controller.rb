class VueArticlesController < ApplicationController
  before_action :set_current_user_article, only: [:edit, :update, :destroy]
  skip_before_action :require_login, only: [:index, :show]

  # GET /vue_articles
  def index
    @articles = Article.includes(:user).all.order(created_at: :desc)
  end

  # GET /vue_articles/1
  def show
    @article = Article.find(params[:id])
  end

  # GET /vue_articles/new
  def new
    @article = current_user.articles.build
  end

  # GET /vue_articles/1/edit
  def edit
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
    if @article.update(article_params)
      redirect_to(vue_article_path(@article), notice: 'Article was successfully updated.')
    else
      render :edit
    end
  end

  # DELETE /vue_articles/1
  def destroy
    @article.destroy
    redirect_to vue_articles_url, notice: 'Article was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_user_article
      @article = current_user.articles.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
