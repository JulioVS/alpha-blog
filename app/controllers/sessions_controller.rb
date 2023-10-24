class SessionsController < ApplicationController

  def new

  end

  def create
    input_email = params[:session][:email] 
    input_password = params[:session][:password] 

    user = User.find_by(email: input_email)

    # debugger

    if user && user.authenticate(input_password)
      # El objeto "session" es provisto por Rails para mantener un "estado de sesión"
      # y almacenar info y/o preferencias del usuario logueado.-
      session[:user_id] = user.id 

      flash[:notice] = "Yes! You are good to go bro!"
      redirect_to user 
    else
      flash.now[:alert] = "Invalid credentials, WTF dude!!!"
      render 'new'
    end
  end

  def destroy
    # Lo deslogueo simplemente borrando el ID de usuario de la sesión!
    session[:user_id] = nil 

    flash[:notice] = "Hasta la fuckin' vista baby!"
    redirect_to root_path
  end

end
