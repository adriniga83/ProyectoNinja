Rails.application.routes.draw do
  resources :estanteria
  #devise_for :users
  devise_for :users, :controllers => { :registrations => 'users/registrations' }
  get 'inicio/index'
  root :to => "inicio#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/principal' => 'principal#index', as: :user_root # creates user_root_path
  namespace :user do
    root 'principal#index' # creates user_root_path
  end
  
  get 'search' => "search#search"
  post 'search' => "search#search"
  put 'search', to: 'search#actualizar', as: 'lista_canciones'
  
  put '/estanteria', to: 'estanteria#actualizar', as: 'actualizar'
  patch '/estanteria', to: 'estanteria#borrar', as: 'borrar'
  
  get 'peliculas' => 'peliculas#index'
  get 'listas' => 'listas#index'
  #put 'estanteria' => "estanteria#actualizar"
  
  #match '/estanteria', to: 'estanteria#actualizar', via: 'put'
  
  #post '/principal' => "search#search"  
end