class PokemonsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :search]
  
  def search_params
    params.permit(:original_trainer_id, :nickname, :gender, :shiny, :nature, :ability, :HPIV, :AtkIV, :DefIV, :SpAIV, :SpDIV, :SpeIV, :hiddenpower, :move1, :move2, :move3, :move4, :ball)
  end
  
  def create
    moves = params["pokemon"]["moves"]
    # Kinda hacky, should fix
    (1..4).each do |n|
      params["pokemon"]["move" + n.to_s + "_id"] = (moves || [])[n - 1]&.to_i
    end
    
    @pokemon = Pokemon.new(params["pokemon"].permit(:user, :species_id, :ball_id, :nature_id, :hidden_power_id, :ability_id, :move1_id, :move2_id, :move3_id, :move4_id))
    @pokemon.user = current_user
    @pokemon.save!
    respond_to do |format|
      format.js {render "new", layout: false}
    end
    # redirect_to user_path(current_user)
    # redirect_to pokemons_path
  end
  
  def index
    @pokemons = Pokemon.all
    render :index
  end
  
  def edit
    @pokemon = Pokemon.find params[:id]
    @pokemon.update_attributes!(pokemon_params)
    flash[:notice] = "Updated #{@pokemon.nickname} (#{@pokemon.species.name})"
    redirect_to pokemons_path
  end

  def destroy
    @pokemon = Pokemon.find params[:id]
    flash[:notice] = "Removed #{@pokemon.nickname} (#{@pokemon.species.name})"
    @pokemon.destroy
    redirect_to pokemons_path
  end
  
  def search
    query = search_params
    query['species'] = Species.find_by(:name => params['species']).id if params['species']
    query['user'] = User.find_by(:username => params['username']).id if params['username']
    @pokemons = Pokemon.where(query)
    render :index
  end
end
