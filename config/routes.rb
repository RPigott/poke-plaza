Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "pokemons#index"

  resources :pokemons
  resources :users, :param => :username
  
  post 'pokemons/search', :to => 'pokemons#search', :as => :pokemon_search
iend
