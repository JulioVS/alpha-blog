class PagesController < ApplicationController
  def home
    # Siempre ha presentado la Home Page, sin ningun proceso previo, es decir
    # va directro a la View sin ningun codigo aqui

    # L158: Se agrega la condicion de que si encuenta un usuario logueado,
    #       no presente la Home Page sino que vaya al listado de articulos
    #
    redirect_to articles_path if logged_in?
  end

  def about

  end
end
