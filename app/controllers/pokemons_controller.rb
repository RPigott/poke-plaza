class PokemonsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  
  def pokemon_params
    params.require(:pokemon).permit(:trainer_id, :nickname, :gender, :shiny, :nature, :ability, :HPIV, :AtkIV, :DefIV, :SpAIV, :SpDIV, :SpeIV, :hiddenpower, :move1, :move3, :move2, :move4, :ball)
  end
  
  def create
    species = Species.find_by(:name => params[:pokemon][:species])
    if not species
      flash[:notice] = "Species '#{params[:pokemon][:species]}' not found."
      render :new and return 
    end
    
    pokemon = pokemon_params
    pokemon[:user] = current_user
    pokemon[:species] = species
    @pokemon = Pokemon.create!(pokemon)

    current_user.pokemons << @pokemon
    species.pokemons << @pokemon
    
    flash[:notice] = "Created #{@pokemon.nickname} (#{@pokemon.species.name})"
    redirect_to pokemons_path
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
end
