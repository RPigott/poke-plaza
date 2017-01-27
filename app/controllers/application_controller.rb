class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:sign_in) do |user_params|
	    user_params.permit(:username, :email)
	  end
    devise_parameter_sanitizer.permit(:sign_up, :keys => [:ign, :friend_code, :trainer_id])
    devise_parameter_sanitizer.permit(:account_update, :keys => [:ign, :friend_code, :trainer_id])
  end
  
  def after_sign_in_path_for(user)
     user_path(user)
  end
  
  def after_sign_out_path_for(user)
      root_path
  end
end
