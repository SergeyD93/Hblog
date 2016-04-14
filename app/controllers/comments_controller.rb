class CommentsController < ApplicationController
  before_action :funk, only: [:create_comment, :destroy]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    respond_to do |format|
      format.js
      format.html
    end
  end

  def destroy
    @comment.destroy
  end


  def create_comment
  end

  private
    def comment_params
      params.require(:comment).permit(:body,:user_id ,:parent_comment_id)
    end

    def funk
      @article = Article.find(params[:article_id])
      @comment = Comment.find(params[:id])
      respond_to do |format|
        format.js
        format.html
      end
    end
end
