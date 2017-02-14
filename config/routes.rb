Rails.application.routes.draw do
  devise_for :users
  get 'principal/index'
  root :to => "principal#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/principal' => 'principal#index2', as: :user_root # creates user_root_path
  namespace :user do
    root 'principal#index2' # creates user_root_path
  end
  
end