class PokemonsController < ApplicationController
  def pokemon_params
    params.require(:pokemon).permit(:species, :trainer_id, :nickname, :gender, :shiny, :nature, :ability, :HPIV, :AtkIV, :DefIV, :SpAIV, :SpDIV, :SpeIV, :hiddenpower, :move1, :move3, :move2, :move4)
  end
  
  def create
    if not session[:user_id] and not Rails.env.test?
      flash[:notice] = "You must login to create new trades."
      redirect_to :index and return 
    end
    
    if not params[:species]
      flash[:notice] = "The required field 'Species' must be filled in."
      render :new and return 
    end
    
    @pokemon = Pokemon.create(params)

    User.find(session[:user_id]).pokemons << @pokemon
    Species.find_by(:name => params[:species]).pokemons << @pokemon
    
    flash[:notice] = "Created #{@pokemon.nickname} (#{@pokemon.species.name})"
    redirect_to :index
  end
  
  def index
    @pokemons = Pokemon.all
    render :index
  end
  
  def edit
    if not session[:user_id] and not Rails.env.test?
      flash[:notice] = "You do not have access to modify this trade."
      redirect_to :index and return 
    end
    
    @pokemon = Pokemon.find params[:id]
    @pokemon.update_attributes!(pokemon_params)
    flash[:notice] = "Updated #{@pokemon.nickname} (#{@pokemon.species.name})"
    redirect_to :index
  end

  def destroy
    if not session[:user_id] and not Rails.env.test?
      flash[:notice] = "You do not have access to remove this trade."
      redirect_to :index and return 
    end
    
    @pokemon = Pokemon.find params[:id]
    flash[:notice] = "Removed #{@pokemon.nickname} (#{@pokemon.species.name})"
    @pokemon.destroy
    redirect_to :index
  end
end
