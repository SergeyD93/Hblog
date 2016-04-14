class ArticlesController < ApplicationController
  before_action :funk, only: [:comment, :destroy]
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
    @article = Article.find(params[:id])
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
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
  end

  def comment

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

    def funk
      @article = Article.find(params[:id])
      respond_to do |format|
        format.js
        format.html
      end
    end
end
