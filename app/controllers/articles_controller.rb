class ArticlesController < ApplicationController

  before_action :check_user, only:[:update, :edit, :destroy]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy

    if @article.destroy
    respond_to do |format|
      format.js
      format.html
    end
      end
  end

  def comment
    @article = Article.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show_comments
    @article = Article.find(params[:article_id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end

    def check_user
      @article = Article.find(params[:id])
      if @article.user_id != current_user.id
        redirect_to articles_path
      end
    end
end
