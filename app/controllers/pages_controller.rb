class PagesController < ApplicationController
  def home
    # Hasta ahora se ha presentado la Home Page sin procesamiento previo,
    # es decir yendo directo a la View sin codigo alguno aqui en el controller.-

    # L158: Se agrega la condición de que si encuentra usuario logueado,
    #       no presente la Home Page sino que vaya al listado de artículos.-
    #
    redirect_to articles_path if logged_in?
  end

  def about

  end
end
