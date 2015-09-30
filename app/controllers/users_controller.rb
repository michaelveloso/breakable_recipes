class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action confirm_user

  def show
    @user = User.find(params[:id])
  end

end

def confirm_user
  if current_user != @user
    flash[:errors] = "You're not signed in as this user"
    redirect_to root_path
  end
end
