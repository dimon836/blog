# frozen_string_literal: true

class ArticlesController < ApplicationController
  include ExceptionHandler

  before_action :authenticate_user!, except: %i[index show]

  before_action :article, only: %i[show edit update destroy]
  before_action :articles, only: :index

  def index; end

  def show
    @comment = Comment.new(article_id: @article.id)
  end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Articles::Create.call(article_params)

    respond_to do |format|
      if @article.errors.any?
        format_error_response(format, :new, :create, :unprocessable_entity)
      else
        format_success_response(format, I18n.t('controllers.articles.created'), :found)
      end
    end
  end

  def update
    @article = Articles::Update.call(@article, article_params)

    respond_to do |format|
      if @article.errors.any?
        format_error_response(format, :show, :update, :unprocessable_entity)
      else
        format_success_response(format, I18n.t('controllers.articles.updated'), :found)
      end
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, status: :found
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end

  def article
    @article ||= Article.find(params[:id])
  end

  def articles
    @articles ||= Article.active_articles
  end

  def format_success_response(format, notice_message, status)
    format.html { redirect_to @article, notice: notice_message, status: }
  end

  def format_error_response(format, render_html, render_turbo_stream, status)
    format.html { render render_html, status: }
    format.turbo_stream { render render_turbo_stream, status: }
  end
end
