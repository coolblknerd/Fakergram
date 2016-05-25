class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters_update, if: :devise_controller?
  before_filter :configure_permitted_parameters_sign_up, if: :devise_controller?
  
  
  protected
  
  def configure_permitted_parameters_update
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit :user_name, :email, :password, :password_confirmation, :current_password
    end
  end
  
  def configure_permitted_parameters_sign_up
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit :user_name, :email, :password, :password_confirmation
    end
  end
end
