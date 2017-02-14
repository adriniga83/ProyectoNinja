class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user, :email, :password])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:user, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:user, :email, :password, :current_password])
  end
end


