class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :username]
  end

  def verify_moderator
    if not current_user.moderator?
      flash[:errors] = 'You don\'t have permission to do that!'
      redirect_to root_path
    end
  end

  def after_sign_in_path_for(resource)
    recipes_path
  end
end
