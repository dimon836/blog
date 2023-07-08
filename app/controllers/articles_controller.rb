class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret",
                               except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Articles::Create.call(article_params)
    if @article.errors.any?
      render :new, status: :unprocessable_entity
    else
      redirect_to @article
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if Articles::Update.call(@article, article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Article.find(params[:id]).destroy
    redirect_to root_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end
