class Librarians::SessionsController < ApplicationController
    ef after_sign_in_path_for(resource)
    '/librarians'
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
