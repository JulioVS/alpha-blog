require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest

  setup do
    # Creo un usuario generico para asi poder crear articulos en el blog
    @my_user = User.create(username: "myuser",
                            email: "myuser@mymail.com",
                            password: "mypass",
                            admin: false
                          )
    # Logueo mi usuario generico al sistema
    sign_in_as(@my_user)
    
    # Creo varias categorias para el articulo
    @cat1 = Category.create(name: "Architecture")   # Va a tener ID = 1
    @cat2 = Category.create(name: "Music")          # Va a tener ID = 2
    @cat3 = Category.create(name: "Technology")     # Va a tener ID = 3
  end

  test "create a new article with correct data" do
    # Como parte del setup, ya parto con un usuario generico logueado, de moodo
    # de poder proceder a crear un nuevo articulo

    # Simulo acceso a pagina de creacion de nuevo articulo
    get '/articles/new'
    # ASSERT 1: Verifico que la pagina exista y cargue
    assert_response :success
    
    # ASSERT 2: Verifico que la cantidad de articulos aumente en uno
    assert_difference 'Article.count', 1 do 
      post articles_path, params: { article: { title: "About ARCH-MSC-TECH",
                                                description: "Description of my new article",
                                                category_ids: [ 1, 2, 3 ] } }
    end

    # ASSERT 3: Verifico que luego crear el articulo haya una redireccion... 
    assert_response :redirect

    # ASSERT 4: ...al show page del nuevo articulo...
    assert_redirected_to article_url(Article.last) 

    # ASSERT 5: ...la sigo y verifico que exista y cargue.-
    follow_redirect!
    assert_response :success

    # ASSERT 6/7, 8/9, 10/11:
    # (Por algun motivo los "assert_match" los cuenta dobles...)
    # Busco texto de mensajes, titulo y categorias en el show page
    assert_match "Article was succesfully", response.body 
    assert_match "About ARCH", response.body 
    assert_match "Music", response.body
  end
  
end
