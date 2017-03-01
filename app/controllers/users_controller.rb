class UsersController < ApplicationController
  def user_params
    params.require(:user).permit(:username, :ign, :friend_code, :trainer_id)
  end

  def index
    @users = User.all
  end
  
  def show
    @user = User.find_by(:username => params[:username])
    @pokemons = @user.pokemons
    @pokemon = Pokemon.new
  end
  
  def availability
    query = params[:username]
    render :html => "#{User.find_by(:username => query).nil?}".html_safe
  end
end
