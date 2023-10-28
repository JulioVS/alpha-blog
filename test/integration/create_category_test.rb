require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest

  setup do 
    # Usuario Admin simbolico para testear funciones que requieran su presencia:

    @admin_user = User.create(username: "adminuser", 
                              email: "adminuser@blog.com",
                              password: "adminpass",
                              admin: true)  # Importante!

    # Simulacion de login mediante funcion ya definida en el test helper
    sign_in_as(@admin_user)
  end

  # TEST 1: Validacion Positiva

  test "get new category form and create category" do
    # Equivalente a visitar con el browser (Http Get) la pagina de crear categoria
    get "/categories/new"

    # Espera un codigo exitoso de HTTP, o sea que la pagina exista y cargue
    assert_response :success                                                # Assert 1

    # Verificar que se agregue una (1) categoria cuando hago el Http Post
    # de creacion. Para ello simulo el Hash de parametros que mandaria Rails

    assert_difference 'Category.count', 1 do                                # Assert 2  
      # Http Post de la nueva cat con los datos en el hash params
      post categories_path, params: { category: { name: "Sports" } } 

      # Ahora quiero verificar que luego del post se haga un redirect
      # (en este caso desde el controller hacia la nueva categoria)
      assert_response :redirect                                             # Assert 3
    end

    # Ahora sigo al redirect y me aseguro que la pagina de destino exista
    follow_redirect!
    assert_response :success                                                # Assert 4

    # Si efectivamente llegue a la pagina "show" donde se muestra la categoria
    # que acabo de crear, ahora quiero asegurarme de que al menos el NOMBRE
    # de mi nueva categoria aparezca en el <Body> de la pagina

    assert_match "Sports", response.body                                    # Assert 5-6
  end

  # TEST 2: Validacion Negativa

  test "get new category form and reject invalid category submission" do 
    get "/categories/new"
    assert_response :success                                                # Assert 7

    # Aqui cheque que NO se agregue la categoria, por ser invalida

    assert_no_difference 'Category.count' do                                # Assert 8
      # Le paso nombre vacio, o sea, invalido
      post categories_path, params: { category: { name: " "} }
    end

    # Al no crearse la categoria, no hay redireccion ni necesidad de seguirla
    #
    # Lo que SI puedo verificar es si se desplegaron los mensajes de error
    # resultantes de la validacion negativa del nombre de categoria vacio.
    #
    # Aqui la idea del curso es buscar en el HTML del partial de mensajes de error
    # un par de elementos especificos de esa pagina, como ser la presencia de la clase
    # de Boostrap "alert" en un tag <div> y la clase "alert-heading" en un tag <h4>,
    # o incluso la simple presencia de la palabra "errors" en el <body>.-

    assert_match "errors", response.body                                   # Assert 9-10
    assert_select 'div.alert'                                              # Assert 11
    assert_select 'h4.alert-heading'                                       # Assert 12                                 
  end
end
