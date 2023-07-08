class CommentsController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret"

  def create
    @comment = Comments::Create.call(comment_params)
    if @comment.save
      redirect_to @comment.article
    else
      render @article, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Comments::Destroy.call(params[:article_id], params[:id])
    redirect_to article_path(@article), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :status).merge(article_id: params[:article_id])
  end
end
