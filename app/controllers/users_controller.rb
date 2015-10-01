class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    confirm_user
    @user = User.find(params[:id])
  end

  private

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
end
