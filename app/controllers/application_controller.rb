class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:sign_in) do |user_params|
	    user_params.permit(:username, :email)
	  end
  end
  
  def after_sign_in_path_for(user)
     user_path(user)
  end
  
  def after_sign_out_path_for(user)
      root_path
  end
end
