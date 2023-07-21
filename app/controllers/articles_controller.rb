class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret",
                               except: [:index, :show]

  before_action :article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
    @article
  end

  def new
    @article = Article.new
  end

  def create
    @article = Articles::Create.call(article_params)
    if @article.errors.any?
      render :new, status: :unprocessable_entity
    else
      redirect_to @article, status: :see_other
    end
  end

  def edit
    @article
  end

  def update
    if Articles::Update.call(@article, article_params)
      redirect_to @article, status: :see_other
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end

  def article
    @article ||= Article.find(params[:id])
  end
end
