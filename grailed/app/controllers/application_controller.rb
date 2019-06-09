class ApplicationController < ActionController::Base
	before_action :configure_devise_params, if: :devise_controller?

	rescue_from CanCan::AccessDenied do |exception|
  		flash[:error] = "Access denied."
  		redirect_to root_path
	end

	def configure_devise_params
		devise_parameter_sanitizer.permit(:sign_up) do |user|
			user.permit(:name, :lastname, :bio, :country, :city, :email, :password, :password_confirmation)
		end
	end 

end

