ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # Agregamos este helper para los casos de prueba de Alpha Blog.-
  #
  # Simula el proceso de login, para poder testear aquellas funciones que
  # requieran de un usuario logueado, o incluso aquellas que necesiten
  # especificamente de un Administrador.-
  #
  # Recordar que en la app en si, el login es mediante Email y Password.-
  #
  def sign_in_as(user) 
    post login_path, params: { session: { email: user.email, password: user.password } } 
  end
end
