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
  end
end
