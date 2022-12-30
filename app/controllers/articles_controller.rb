class ArticlesController < ActionController::Base #ApplicationController
  def show
    #byebug
      # Debugger!!! Pasa el proceso en el navegador y me habilita
      # la consola (donde ejecutamos "rails s") para debuggear
    @article = Article.find(params[:id])
      # El prefijo "@" hace que mi variable (aqui "article") se transforme
      # en una variable DE INSTANCIA, lo cual la hace disponible para
      # la vista HTML/ERB correspondiente y alli puedo extraer sus
      # datos para exhibir!
      # "params" es la estructura de hash que viene desde el navegador
      # complementando la accion GET de HTTP, aqui por ejemplo
      # ":id" seria el numero de articulo a buscar en la BD y luego 
      # exhibir en el navegador.-
  end

  def index
    @articles = Article.all 
  end
end