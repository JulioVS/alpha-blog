Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  # Rutas de páginas genéricas (ej: Home y About), remite a Pages Controller
  root 'pages#home'
  get 'about', to: 'pages#about'

  # Rutas para todo lo relacionado a artículos, remite a Articles Controller
  resources :articles

  # Ruta específica para el Sign Up de usuarios, remite a Users Controller
  get 'signup', to: 'users#new'
  # Rutas para todo lo demas relacionado a usuarios, remite a Users Controller
  resources :users, except: [:new] 

  # Para el Log In vamos a crear una ruta que no es RESTful, es decir que
  # no trata con un recurso como ser Usuarios o Articulos ni va a base de datos
  # sino que va a operar a nivel de "sesión", en memoria.-
  # Para ello vamos a crear un "Sessions" (plural) Controller.-
  get 'login', to: 'sessions#new'         # Display del login
  post 'login', to: 'sessions#create'     # Submit del login
  delete 'logout', to: 'sessions#destroy' # Baja de la sesión
end
