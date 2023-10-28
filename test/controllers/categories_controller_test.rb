require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Sports")

    # Creo un usuario administrador simbolico para que los test que requieran presencia 
    # de admin logueado puedan testearse

    @admin_user = User.create(username: "adminuser", 
                              email: "adminuser@blog.com",
                              password: "adminpass",
                              admin: true)  # Importante!

    # Para loguearlo tengo que invocar la funcion "sign_in_as(@admin_user)" en cada 
    # test que asi lo requiera. La funcion la definimos en el modulo "test_helper.rb" para 
    # que sea alcanzable desde cualquier test.-
  end

  test "should get index" do
    # No requiere Admininstrador logueado, es publico.-

    get categories_url
    assert_response :success
  end

  test "should get new" do
    # Requiere Administrador logueado, invoco funcion de login...
    sign_in_as(@admin_user)

    get new_category_url
    assert_response :success
  end

  test "should create category" do
    # Requiere Administrador logueado, invoco funcion de login...
    sign_in_as(@admin_user)

    assert_difference("Category.count", 1) do
      post categories_url, params: { category: { name: "Travel" } }
    end
  
    assert_redirected_to category_url(Category.last)
  end

  test "should not create category if not admin" do 
    # Como "crear categoria" requiere Admin logueado, aqui omitimos adrede invocar
    # la funcion de login, para comprobar que SIN Admin la categoria NO se crea

    assert_no_difference("Category.count") do
      post categories_url, params: { category: { name: "Travel" } }
    end
  
    assert_redirected_to categories_url
  end

  test "should show category" do
    # No requiere Admininstrador logueado, es publico.-

    get category_url(@category)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "should update category" do
  #   patch category_url(@category), params: { category: {  } }
  #   assert_redirected_to category_url(@category)
  # end

  # test "should destroy category" do
  #   assert_difference("Category.count", -1) do
  #     delete category_url(@category)
  #   end
  #
  #   assert_redirected_to categories_url
  # end
end
