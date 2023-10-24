class ApplicationController < ActionController::Base
  # Esto hace que los metodos sean accesibles para los Views ademas de los
  # Controllers, como si estuviesen redactado en "AplicationHelper"
  #
  helper_method :current_user, :logged_in?

  # Me traigo los metodos de ApllicationHelper (views) para aqui, de modo de
  # poder usarlos en los controllers
  #
  def current_user
    # Como se lee esto...a ver...
    #
    # 1. Defino una variable llamada "@current_user"
    #
    # 2. Si cuando ingreso al metodo esa variable no tiene mada,
    #    entonces busco el User mediante el ID de usuario almacenado
    #    en la sesion, SIEMPRE Y CUANDO haya uno (es decir haya alguien
    #    logueado)
    #
    # 3. Si al entrar al metodo la variable "@current_user" ya existe
    #    y tiene algo, entonces simplemente devuelve ese valor y no
    #    reitera la busqueda, pues implicaria un query redundante a la BD
    #
    # Para todo esto se usa el operador "Or Equal" de Ruby "||=" que lo que
    # hace es asignar valor a una variable SOLAMENTE si no estuviese ya 
    # definida.-
    #
    @current_user ||= User.find(session[:user_id]) if session[:user_id] 
  end

  def logged_in?
    # Y este, a ver...
    # 
    # Aqui lo que se quiere es devolver un valor lógico, que indique si hay
    # un usuario logueado o no
    # Esto equivaldria a evaluar si mi variable @current_user tiene ya un 
    # valor asignado o no: si tiene, devuelve "true" y si es nil devuelve
    # false.-
    #
    # Aqui para "boolean-izar" una variable simplemente se le antepone
    # un operador "!!" que al menos yo lo interpreto como una especie de
    # doble negacion, algo asi como "si es falso que la variable sea nil"
    # entonces hay alguien logueado... supongo!
    #
    
    # FIX JE: 
    #
    # Si se llama a "logged_in?" sin que ANTES en algun lugar se haya invocado a
    # "current_user", la funcion "logged_in?" NO FUNCIONA, aunque ya haya un 
    # usuario cargado en la sesion!
    #
    # Esto es porque el User ID esta en "session" pero la variabla "current_user"
    # no ha sido creada aun! (y por ello "logged_in?" siempre arroja falso)
    #
    # Por ende lo que hago para corregir el problema es invocar a "current_user" 
    # mismo desde logged_in?, aqui al comienzo: 
    current_user

    !!@current_user
  end
end
