class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy] 

  def show
    # no hace nada mas pues la la busqueda del articulo ya la hizo "set_article"
  end

  def index
    # Modo clasico de obtener los items (sin paginar)
    # @articles = Article.all

    # Agrego paginado mediante uso del Gem "will_paginate"
    @articles = Article.paginate(page: params[:page], per_page: 5) 
  end

  def new
    @article = Article.new 
  end

  def edit
    # no hace nada mas pues la la busqueda del articulo ya la hizo "set_article"
  end

  def create
    @article = Article.new(article_params)

    # L130: Luego de agregar Usuarios y la relacion 1 a n con Articulos
    #       necesito colocar un user_id "dummy" provisoriamente hasta que
    #       este implementado el sistema de autenticacion, pues de otro modo
    #       va a dar error al momento de grabar en la BD.-
    #       Por ahora a cada nuevo articulo le pongo el primer usuario que
    #       que ya tenga cargado en la BD.-
    @article.user = User.first 

    if @article.save
      flash[:notice] = "Article was succesfully created"
      redirect_to(:action => 'show', id: @article.id)
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was succesfully updated"
      redirect_to(:action => 'show', id: @article.id)
    else
      render 'edit'
    end 
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end
 
  def article_params
    params.require(:article).permit(:id, :title, :description)
  end
end