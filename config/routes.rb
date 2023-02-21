Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
    # Mi controlador será "pages" y mi acción será "home" // JE.-
  get 'about', to: 'pages#about'
    # Para la pagina "/about" (GET de HTML), asocia el Get con una
    # acción llamada 'about' de mi controlador de paginas // JE.- 
  resources :articles, only: [:show, :index, :new, :create, :edit, :update]
end
