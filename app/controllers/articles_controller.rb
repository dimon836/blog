class ArticlesController < ApplicationController
  include ExceptionHandler

  http_basic_authenticate_with name: "dhh", password: "secret",
                               except: [:index, :show]

  before_action :article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Articles::Create.call(article_params)
    if @article.errors.any?
      render :new, status: :unprocessable_entity
    else
      redirect_to @article, status: :found
    end
  end

  def edit
  end

  def update
    if Articles::Update.call(@article, article_params)
      redirect_to @article, status: :found
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path, status: :found
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end

  def article
    @article ||= Article.find(params[:id])
  end
end
