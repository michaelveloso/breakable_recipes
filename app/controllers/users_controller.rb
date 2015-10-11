class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    confirm_user
    @user = this_user
  end

  def destroy
    confirm_user
    this_user.destroy
    flash[:success] = "Account deleted!"
    redirect_to root_path
  end

  private

  def this_user
    User.find(params[:id])
  end

  def confirm_user
    if current_user != this_user
      flash[:errors] = "You're not signed in as this user"
      redirect_to root_path
    end
  end
end
