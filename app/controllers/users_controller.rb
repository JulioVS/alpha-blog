class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update] 

  def show
    # Modo clasico de obtener los items (sin paginar)
    # @articles = @user.articles
  
    # Agrego paginado a los articulos del usuario
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def index
    # Modo clasico de obtener los items (sin paginar)
    # @users = User.all 
 
    # Agrego paginado mediante uso del Gem "will_paginate"
    @users = User.paginate(page: params[:page], per_page: 5) 
  end
  
  def new
    @user = User.new 
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information was succesfully updated"
      redirect_to @user 
    else
      flash[:notice] = "No no no, try again motherfucker!"
      render 'edit'
    end
  end
  
  def create
    @user = User.new(user_params)

    if @user.save
      # Al crear el nuevo usuario, tambien hago su Log in
      session[:user_id] = @user.id 

      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have sucessfully signed up"
      redirect_to articles_path
    else
      flash[:notice] = "Not Welcome, you suck!"
      render 'new'
    end
  end

  private

  def set_user
    @user = User.find(params[:id]) 
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
