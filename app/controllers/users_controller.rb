class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy] 
  before_action :require_user, only: [:edit, :update, :destroy] 
  before_action :require_same_user, only: [:edit, :update, :destroy]  

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

  def destroy
    # Barrerá con el usuario y todos sus articulos automáticamente, debido
    # a la dependencia que declaré al principio del User model.-
    @user.destroy

    # IMPORTANTE!
    # Hay que sacar el user ID del objeto session a mano!
    # Caso contrario queda "logueado" no permitiendo hacer nuevos logins
    #
    # UPDATE L172:
    # Ahora que un administrador también puede borrar usuarios, es importante
    # que solo deslogueemos la sesión cuando un usuario se borre a si mismo
    # (caso normal) pero NO cuando sea el Admin que lo esté borrando.
    # Si es el Admin borrando un usuario, puede y debe permanecer logueado
    # para poder seguir haciendo tareas de admimnistracion.
    # Por ende, simplemente se desloguea la sesión si el usuario que se está
    # borrando coincide con el usuario actualmente logueado.-
    session[:user_id] = nil if @user == current_user
    
    flash[:notice] = "Goodbye to you and your effin' articles mate!!!"
    redirect_to articles_path 
  end 

  private

  def set_user
    @user = User.find(params[:id]) 
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    # Si no es el propio usuario ni un Administrador, lo rebota.-
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own account"
      redirect_to @user 
    end
  end

end
