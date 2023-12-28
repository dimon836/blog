# frozen_string_literal: true

class CommentsController < ApplicationController
  http_basic_authenticate_with name: 'dhh', password: 'secret'

  before_action :authenticate_user!, only: %i[edit update]

  def edit; end

  def create
    @comment = Comments::Create.call(comment_params)

    respond_to do |format|
      if @comment.errors.any?
        @article = @comment.article
        format_error_response(format, 'articles/show', nil, :unprocessable_entity)
      else
        format_success_response(format, I18n.t('controllers.comments.created'), @comment.article, :see_other)
      end
    end
  end

  def update
    @comment = Comments::Update.call(@comment, comment_params)

    respond_to do |format|
      if @comment.errors.any?
        format_error_response(format, :edit, :update, :unprocessable_entity)
      else
        format_success_response(format, I18n.t('controllers.comments.updated'), @comment.article, :found)
      end
    end
  end

  def destroy
    @destroyed_comment = Comments::Destroy.call(params[:article_id], params[:id])
    handle_destroyed_comment
  end

  private

  def handle_destroyed_comment
    if @destroyed_comment.errors.present?
      redirect_to article_path(params[:article_id]), alert: @destroyed_comment.errors[:not_found], status: :see_other
    else
      redirect_to article_path(params[:article_id]), status: :see_other
    end
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body, :status).merge(article_id: params[:article_id])
  end

  def comment
    @comment = Comment.find(params[:id])
  end

  def format_success_response(format, notice_message, article, status)
    format.html { redirect_to article, flash: { updated_comment: notice_message }, status: }
  end

  def format_error_response(format, render_html, render_turbo_stream, status)
    format.html { render render_html, status: }
    format.turbo_stream { render render_turbo_stream, status: } unless render_turbo_stream.nil?
  end
end
