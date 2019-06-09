class ApplicationController < ActionController::Base
	before_action :configure_devise_params, if: :devise_controller?

	def configure_devise_params
		devise_parameter_sanitizer.permit(:sign_up) do |user|
			user.permit(:name, :lastname, :bio, :country, :city, :email)
		end
	end 

end

