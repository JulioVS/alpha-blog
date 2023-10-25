class ApplicationController < ActionController::Base
  # Esto hace que los metodos sean accesibles para los Views ademas de los
  # Controllers, como si estuviesen redactados en "ApplicationHelper"
  #
  helper_method :current_user, :logged_in?

  # Me traigo los metodos desde ApplicationHelper (views) hacia aqui, de modo de
  # poder usarlos en los controllers
  #
  def current_user
    # Como se lee esto...a ver...
    #
    # 1. Defino una variable de instancia llamada "@current_user"
    #
    # 2. Si cuando ingreso al metodo esa variable no tiene mada,
    #    entonces busco el User mediante el ID de usuario almacenado
    #    en la sesion, SIEMPRE Y CUANDO exista (es decir haya alguien
    #    logueado)
    #
    # 3. Si al entrar al metodo la variable "@current_user" ya existe
    #    y tiene algo, entonces simplemente devuelve ese valor y no
    #    reitera la busqueda, pues implicaria un query redundante a la BD
    #
    # Para todo esto se usa el operador "Or Equal" de Ruby "||=" que lo que
    # hace es asignar valor a una variable SOLAMENTE si ya no está  
    # definida.-
    #
    @current_user ||= User.find(session[:user_id]) if session[:user_id] 
  end

  def logged_in?
    # Y este, a ver...
    # 
    # Aqui lo que se quiere es devolver un valor lógico, que indique si hay
    # un usuario logueado o no.
    # Esto equivaldria a evaluar si mi variable @current_user tiene ya un 
    # valor cargado o no: si lo tiene devuelve "true", si es nil devuelve
    # "false".-
    #
    # Aqui para "boolean-izar" una variable simplemente se le antepone
    # un operador "!!" que al menos yo lo interpreto como una especie de
    # doble negacion, algo asi como "si es falso que la variable sea nula"
    # entonces hay alguien logueado, ergo "true"... supongo!
    #
    
    # FIX JE: 
    #
    # Si se llama a "logged_in?" sin que PREVIAMENTE se haya invocado "current_user"
    # en algun lugar de la app, ésta NO FUNCIONARÁ, ni siquiera en el caso de que
    # ya haya un usuario logueado y cargado en la sesion!
    #
    # Esto es porque aunque el User ID ya esté en "session", la variable "@current_user"
    # no habrá sido creada aun! (y por ello "logged_in?" siempre arrojará 'falso")
    #
    # Por ende, lo que hago para corregir ese problema es simplemente invocar a  
    # "current_user" al comienzo de la propia "logged_in?" y listo.-
    current_user

    !!@current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end
end
