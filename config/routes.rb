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
end
