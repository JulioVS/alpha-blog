require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category1 = Category.create(name: "Sports")
    @category2 = Category.create(name: "Travel")
  end

  test "should show categories listing" do 
    # Verifica que exista el view de listado de categorias
    get '/categories'    
    assert_response :success 

    # Verifica que se desplieguen los nombres de las categorias creadas
    assert_match "Sports", response.body 
    assert_match "Travel", response.body 

    # Verifica que los nombres a su vez contengan links a sus respectivos "show" views
    assert_select "a[href=?]", category_path(@category1), text: @category1.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end
end
