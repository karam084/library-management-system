class Librarians::RegistrationsController < ApplicationController
    before_action :configure_sign_up_params, only: [:create]
   
    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :library, :approved])
    end
  
    # If you have extra params to permit, append them to the sanitizer.
    def after_sign_up_path_for(resource)
        '/librarians'
    end
  

end
