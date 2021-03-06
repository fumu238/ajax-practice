class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search

  def after_sign_in_path_for(resource)
    user_path(@user)
  end

  def search
      @q = Book.ransack(params[:q])
  end

  protected

  def configure_permitted_parameters
  	 devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  	 devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end