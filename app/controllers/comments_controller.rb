class CommentsController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret"

  def create
    @comment = Comments::Create.call(comment_params)
    @article = @comment.article
    if @comment.errors.any?
      render 'articles/show'
    else
      redirect_to @comment.article, status: :see_other
    end
  end

  def destroy
    @destroy_errors = Comments::Destroy.call(params[:article_id], params[:id])
    if @destroy_errors.present?
      redirect_to article_path(params[:article_id]), alert: @destroy_errors["not_found"], status: :not_found
    else
      redirect_to article_path(params[:article_id]), status: :see_other
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :status).merge(article_id: params[:article_id])
  end
end
