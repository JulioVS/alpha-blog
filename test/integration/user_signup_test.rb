require "test_helper"

class UserSignupTest < ActionDispatch::IntegrationTest

  test "sign up new user with correct data" do
    # Simula acceso a la URL de crear nuevo usuario del blog
    get '/signup'

    # ASSERT 1: Verifica que la pagina exista y cargue
    assert_response :success 

    # ASSERT 2: Verifica si el numero de usuarios aumenta en uno tras el post con datos correctos
    assert_difference 'User.count', 1 do 
      post users_path, params: { user: { username: "Vandenberg", email: "vanden@berg.com", password: "mypass" } }
    end

    # ASSERT 3: Verifica si tras crear el usuario redirige a otra pagina
    assert_response :redirect

    # ASSERT 4: Sigo la redireccion y me fijo si la pagina destino existe y carga
    follow_redirect!
    assert_response :success

    # ASSERT 5-6: Deberia ser la pagina de listado de articulos; busco el encabezado en la pagina
    assert_match "Listing all articles", response.body 

    # ASSERT 7: Verifico que la ID del nuevo usuario se haya cargado en la sesion
    assert session[:user_id] != nil

    # ASSERT 8: Verifico que el nuevo usuario NO haya quedado ADministrador
    assert !User.last.admin?
  end
  
end
