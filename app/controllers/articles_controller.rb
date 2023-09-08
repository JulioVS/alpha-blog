class ArticlesController < ApplicationController
  def show
    # debugger
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new 
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    # render plain: params[:article] 
    # @article = Article.new(params.require(:article).permit(:title, :description))
    # @article.save 
    # redirect_to article_path(:article) 

    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was succesfully created"
      redirect_to(:action => 'show', id: @article.id)
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article was succesfully updated"
      redirect_to(:action => 'show', id: @article.id)
    else
      render 'edit'
    end 
  end

  private

  def article_params
    params.require(:article).permit(:id, :title, :description)
  end
end