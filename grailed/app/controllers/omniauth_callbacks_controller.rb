class OmniauthCallbacksController < Devise::OmniauthCallbacksController
   skip_before_action :verify_authenticity_token
   
   def omniauth_auth
	@user = User.from_omniauth(request.env["omniauth.auth"])
	sign_in_and_redirect @user
   end
   
   def google_oauth2
    	@user = User.from_omniauth(request.env["omniauth.auth"])
	sign_in_and_redirect @user
   end
end
