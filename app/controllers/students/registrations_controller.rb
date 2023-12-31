class Students::RegistrationsController < ApplicationController
    before_action :configure_sign_up_params, only: [:create]
    # before_action :configure_account_update_params, only: [:update]
  
    # GET /resource/sign_up
    def new
      @student = Student.new
end
