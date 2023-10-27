require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    # Aqui va el setup (preparacion) comun a todos nuestros tests.
    #
    # Es decir lo que pongamos aqui (ej la creacion de un objeto o definicion de 
    # variable) va a ejecutarse antes de cada uno de los tests que definamos a 
    # continuacion.-
    #
    @category = Category.new(name: "Sports") 
  end

  test "category should be vaild" do 
    # Uso de "assert"
    #
    # Aqui el test es existoso si valid? da "true", o sea si el objeto ES efectivamente valido
    # cuando se crea de forma correcta y un nombre no vacio ni repetido
    #
    # => DAR VALIDO = Test Exitoso!
    #
    assert @category.valid?
  end

  test "name should be present" do 
    # Uso de "assert_not"
    #
    # En este otro, en cambio, el test es exitoso si valid da "false", es decir que
    # efectivamente el objeto NO sea valido cuando se trata de crear con nombre vacío
    #
    # => DAR INVALIDO = Test Exitoso!
    #
    @category.name = " "
    assert_not @category.valid? 
  end

  test "name should be unique" do 
    @category.save
    @category2 = Category.new(name: "Sports") 
    assert_not @category2.valid? 
  end

  test "name should not be too long" do 
    @category.name = "a" * 26     # En el Model puse largo máximo = 25.-
    assert_not @category.valid? 
  end

  test "name should not be too short" do 
    @category.name = "a" * 2      # En el Model puse largo mínimo = 3.-
    assert_not @category.valid? 
  end

end