class UsersController < ApplicationController

  def new
    @user = User.new 
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
