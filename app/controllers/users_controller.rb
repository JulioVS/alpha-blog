class UsersController < ApplicationController

  def show
    @user = User.find(params[:id]) 
    @articles = @user.articles
  end
  
  def index
    @users = User.all 
  end
  
  def new
    @user = User.new 
  end

  def edit
    @user = User.find(params[:id]) 
  end

  def update
    @user = User.find(params[:id]) 
    if @user.update(user_params)
      flash[:notice] = "Your account information was succesfully updated"
      redirect_to @user 
    else
      flash[:notice] = "No no no, try again motherfucker!"
      render 'edit'
    end
  end
  
  def create
    # debugger
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have sucessfully signed up"
      redirect_to articles_path
    else
      flash[:notice] = "Not Welcome, you suck!"
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
