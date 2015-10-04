class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :username]
  end

  def confirm_user
    if current_user.present?
      if current_user != User.find(params[:id])
        flash[:errors] = "You're not signed in as this user"
        redirect_to root_path
      end
    else
      flash[:errors] = "You're not signed in"
      redirect_to root_path
    end
  end

  def check_permission
    if not current_user.role == 'admin' || current_user.role == 'moderator'
      flash[:errors] = 'You don\'t have permission to do that!'
      redirect_to root_path
    end
  end
end
