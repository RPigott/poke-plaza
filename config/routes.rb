Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "pokemons#index"

  get 'pokemons/search', :to => 'pokemons#search', :as => :pokemon_search
  get 'pokemons/username_availability', :to => 'users#availability', :as => :user_availability
  get 'species/:id/abilities', :to => 'species#abilities'
  get 'species/:id/moves', :to => 'species#moves'
  get 'species/:id/genders', :to => 'species#genders'

  resources :pokemons
  resources :users, :param => :username
end
