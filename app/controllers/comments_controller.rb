class CommentsController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret"

  def create
    @comment = Comments::Create.call(comment_params)
    @article = @comment.article
    if @comment.errors.any?
      render 'articles/show', status: :unprocessable_entity
    else
      redirect_to @comment.article, status: :see_other
    end
  end

  def destroy
    @destroyed_comment = Comments::Destroy.call(params[:article_id], params[:id])
    if @destroyed_comment.errors.present?
      redirect_to article_path(params[:article_id]), alert: @destroyed_comment.errors[:not_found], status: :see_other
    else
      redirect_to article_path(params[:article_id]), status: :see_other
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :status).merge(article_id: params[:article_id])
  end
end
